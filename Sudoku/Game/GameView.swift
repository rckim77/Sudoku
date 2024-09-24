//
//  GameView.swift
//  Sudoku
//
//  Created by Ray Kim on 6/30/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import SwiftData

enum SavedState {
    case startedUnsaved
    case startedSaved
    case saved
    case unsaved
}

struct GameView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var savedGameState: [SavedGameState]

    @State var savedState: SavedState
    @State private(set) var selectedCell = SelectedCell()
    @State private(set) var userAction = UserAction()
    @State private(set) var editState = EditState(isEditing: false)
    @State private(set) var workingGrid: GridValues
    @State private(set) var editGrid = EditGridValues(grid: [])
    @State private var alertItem: AlertItem?
    @State private var alertIsPresented: Bool = false
    @State private var hintButtonIsLoading: Bool = false
    @State private var saveButtonAnimate: Bool = false

    let viewModel: GameViewModel
    
    private var hasUpdatedGrid: Bool {
        return workingGrid.grid.count > workingGrid.startingGrid.count || !editGrid.isEmpty
    }
    
    var body: some View {
        ZStack {
            Color("dynamicBackground")
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack(spacing: viewModel.verticalSpacing) {
                    Spacer()
                    SudokuGrid(selectedCell: selectedCell,
                               userAction: userAction,
                               editGrid: editGrid.grid,
                               workingGrid: workingGrid)
                    Spacer()
                        .frame(maxWidth: .infinity,
                               maxHeight: viewModel.getSpacerMaxHeight(geometry.size.height))
                    KeysRow(editGrid: editGrid,
                            userAction: userAction,
                            workingGrid: workingGrid,
                            alert: $alertItem,
                            alertIsPresented: $alertIsPresented,
                            selectedCoordinate: selectedCell.coordinate,
                            isEditing: editState.isEditing,
                            savedState: $savedState)
                    Spacer()
                        .frame(maxHeight: viewModel.verticalSpacing)
                    NewGameButton(alert: $alertItem,
                                  alertIsPresented: $alertIsPresented,
                                  hasUpdatedGrid: hasUpdatedGrid,
                                  savedState: savedState)
                    Spacer()
                        .frame(maxHeight: viewModel.bottomVerticalSpacing)
                }
                .toolbar {
                    ToolbarItemGroup(placement: viewModel.toolbarItemPlacement) {
                        if !isVision {
                            Spacer()
                        }
                        HStack(spacing: viewModel.toolbarItemHorizontalSpacing) {
                            ClearButton(selectedCoordinate: selectedCell.coordinate,
                                        editGrid: editGrid,
                                        editState: editState,
                                        userAction: userAction,
                                        workingGrid: workingGrid,
                                        savedState: $savedState)
                            EditButton(editState: editState)
                            HintButton(isLoading: $hintButtonIsLoading) {
                                Task {
                                    do {
                                        hintButtonIsLoading = true
                                        if let hintMessage = try await viewModel.getHint(grid: workingGrid.grid) {
                                            alertItem = .hintSuccess(hint: hintMessage)
                                            alertIsPresented = true
                                        } else {
                                            alertItem = .hintError
                                            alertIsPresented = true
                                        }
                                        hintButtonIsLoading = false
                                    } catch {
                                        hintButtonIsLoading = false
                                        alertItem = .hintError
                                        alertIsPresented = true
                                    }
                                }
                            }
                            .disabled(hintButtonIsLoading)
                            Button("Save", systemImage: "square.and.arrow.down") {
                                checkSaveIfNeeded()
                                saveButtonAnimate.toggle()
                            }
                            .symbolEffect(.bounce.down.byLayer, value: saveButtonAnimate)
                            .tint(.primary)
                        }
                        .padding(.bottom, viewModel.toolbarBottomPadding)
                        if !isVision {
                            Spacer()
                        }
                    }
                }
                .alert(alertItem?.title ?? "Alert",
                       isPresented: $alertIsPresented,
                       presenting: alertItem
                ) { item in
                    switch item {
                    case .newGame:
                        Button(role: .destructive) {
                            dismiss()
                        } label: {
                            Text("Confirm")
                        }
                        Button(role: .cancel) {} label: {
                            Text("Cancel")
                        }
                        
                    case .completedCorrectly:
                        Button("Go back") {
                            dismiss()
                        }
                    case .hintSuccess(_):
                        Button("Thanks") {}
                    case .completedIncorrectly, .hintError:
                        Button("Dismiss") {}
                    case .overwriteWarning:
                        Button(role: .destructive) {
                            save()
                        } label: {
                            Text("Confirm")
                        }
                    }
                } message: { item in
                    Text(item.message)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear() {
            switch savedState {
            case .startedUnsaved:
                resetGrids(for: viewModel.difficulty)
            case .startedSaved, .saved:
                break
            case .unsaved:
                resetToPreviouslySavedGrid()
            }
        }
    }
    
    private func resetGrids(for level: Difficulty.Level) {
        workingGrid.resetTo(newGrid: GridFactory.randomGridForDifficulty(level: level))
        selectedCell.coordinate = nil
        userAction.action = .none
        editState.isEditing = false
        editGrid.grid = []
    }
    
    private func resetToPreviouslySavedGrid() {
        guard let savedGame = savedGameState.first else {
            return
        }
        workingGrid.resetFrom(savedGame: savedGame)
        selectedCell.coordinate = savedGame.selectedCell
        
        userAction.action = savedGame.userAction
        editState.isEditing = savedGame.isEditing
        editGrid.grid = savedGame.editValues
    }
    
    private func checkSaveIfNeeded() {
        if !savedGameState.isEmpty {
            alertItem = .overwriteWarning
            alertIsPresented = true
        } else {
            save()
        }
    }
    
    /// Currently we only save one game. To fetch, always get the first SavedGameState object in the model container.
    private func save() {
        let gameState = SavedGameState(workingGrid: workingGrid.grid, startingGrid: workingGrid.startingGrid, colorGrid: workingGrid.colorGrid, userAction: userAction.action, selectedCell: selectedCell.coordinate, isEditing: editState.isEditing, editValues: editGrid.grid, difficulty: viewModel.difficulty)
        
        try? modelContext.delete(model: SavedGameState.self)
        modelContext.insert(gameState)
        try? modelContext.save()
        savedState = .saved
    }
}

#Preview {
    GeometryReader { geometry in
        GameView(savedState: .startedUnsaved, workingGrid: GridValues(startingGrid: GridFactory.easyGrid), viewModel: GameViewModel(difficulty: .easy))
            .environment(WindowSize(size: geometry.size))
    }
}
