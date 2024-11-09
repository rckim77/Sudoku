//
//  GameView.swift
//  Sudoku
//
//  Created by Ray Kim on 6/30/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import SwiftData

enum SavedState: Codable {
    case startedUnsaved
    case startedSaved
    case saved
    case unsaved
}

struct GameView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var savedGameState: [GameConfig]

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
    @State private(set) var undoManager = UndoManager()

    let viewModel: GameViewModel
    
    private var hasUpdatedGrid: Bool {
        return workingGrid.grid.count > workingGrid.startingGrid.count || !editGrid.isEmpty
    }

    @AppStorage("totalGamesCompleted") var totalGamesCompleted = 0
    @AppStorage("totalEasyGamesCompleted") var totalEasyGamesCompleted = 0
    @AppStorage("totalMediumGamesCompleted") var totalMediumGamesCompleted = 0
    @AppStorage("totalHardGamesCompleted") var totalHardGamesCompleted = 0
    
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
                            savedState: $savedState,
                            undoManager: undoManager)
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
                            Button("Undo", systemImage: "arrow.uturn.backward") {
                                handleUndo()
                            }
                            .disabled(!undoManager.canUndo)
                            .tint(.primary)
                            
                            ClearButton(selectedCoordinate: selectedCell.coordinate,
                                      editGrid: editGrid,
                                      editState: editState,
                                      userAction: userAction,
                                      workingGrid: workingGrid,
                                      savedState: $savedState,
                                      undoManager: undoManager)
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
                            saveUserStats()
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
        let gameState = GameConfig(savedState: savedState, workingGrid: workingGrid.grid, startingGrid: workingGrid.startingGrid, colorGrid: workingGrid.colorGrid, userAction: userAction.action, selectedCell: selectedCell.coordinate, isEditing: editState.isEditing, editValues: editGrid.grid, difficulty: viewModel.difficulty)
        
        try? modelContext.delete(model: GameConfig.self)
        modelContext.insert(gameState)
        try? modelContext.save()
        savedState = .saved
    }

    private func saveUserStats() {
        totalGamesCompleted += 1

        switch viewModel.difficulty {
        case .easy:
            totalEasyGamesCompleted += 1
        case .medium:
            totalMediumGamesCompleted += 1
        case .hard:
            totalHardGamesCompleted += 1
        }
    }

    private func handleUndo() {
        guard let lastAction = undoManager.undo() else { return }
        
        editState.isEditing = lastAction.wasEditing
        
        if lastAction.wasEditing {
            switch lastAction.editActionType {
            case .add(let digit):
                // If we were adding a digit, remove it
                var newValues = lastAction.previousEditValues
                newValues.remove(digit)
                updateEditValues(at: lastAction.coordinate, with: newValues)
            case .remove(let digit):
                // If we were removing a digit, add it back
                var newValues = lastAction.previousEditValues
                newValues.insert(digit)
                updateEditValues(at: lastAction.coordinate, with: newValues)
            case .none:
                // Handle regular value changes and clearAll
                updateEditValues(at: lastAction.coordinate, with: lastAction.previousEditValues)
            }
        } else {
            if let previousValue = lastAction.previousValue {
                workingGrid.add(CoordinateValue(r: lastAction.coordinate.r,
                                              c: lastAction.coordinate.c,
                                              s: lastAction.coordinate.s,
                                              v: previousValue))
            } else {
                workingGrid.removeValue(at: lastAction.coordinate)
            }
            
            updateEditValues(at: lastAction.coordinate, with: lastAction.previousEditValues)
        }
        
        savedState = .unsaved
    }

    private func updateEditValues(at coordinate: Coordinate, with values: Set<Int>) {
        editGrid.removeValues(at: coordinate)
        if !values.isEmpty {
            let editValues = CoordinateEditValues(r: coordinate.r,
                                                c: coordinate.c,
                                                s: coordinate.s,
                                                values: values)
            editGrid.grid.append(editValues)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        GameView(savedState: .startedUnsaved, workingGrid: GridValues(startingGrid: GridFactory.easyGrid), viewModel: GameViewModel(difficulty: .easy))
            .environment(WindowSize(size: geometry.size))
    }
}
