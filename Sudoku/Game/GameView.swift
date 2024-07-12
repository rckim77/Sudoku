//
//  GameView.swift
//  Sudoku
//
//  Created by Ray Kim on 6/30/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct GameView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(SelectedCell.self) private var selectedCell: SelectedCell
    @Environment(UserAction.self) private var userAction: UserAction
    @Environment(EditState.self) private var editState: EditState
    @Environment(GridValues.self) private var workingGrid: GridValues
    @Environment(EditGridValues.self) private var editGrid: EditGridValues
    @Environment(Difficulty.self) private var difficulty: Difficulty
    @State
    private var alertItem: AlertItem?
    @State
    private var alertIsPresented: Bool = false
    @State
    private var hintButtonIsLoading: Bool = false
    
    let viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Color("dynamicBackground")
                    .edgesIgnoringSafeArea(.all)
            VStack(spacing: viewModel.verticalSpacing) {
                if isIpad {
                    Spacer()
                }
                SudokuGrid(editGrid: editGrid.grid)
                HStack(spacing: viewModel.actionButtonsHorizontalSpacing) {
                    ClearButton()
                    EditButton()
                    Button(action: {
                        save()
                    }) {
                        Text("Save")
                            .font(.system(.headline, design: .rounded))
                    }
                    .dynamicButtonStyle(textColor: Color.black, backgroundColor: Color("dynamicGray"))
                }
                KeysRow(alert: $alertItem,
                        alertIsPresented: $alertIsPresented,
                        selectedCoordinate: selectedCell.coordinate,
                        isEditing: editState.isEditing)
                HStack(spacing: viewModel.actionButtonsHorizontalSpacing, content: {
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
                    NewGameButton(alert: $alertItem,
                                  alertIsPresented: $alertIsPresented,
                                  editGrid: editGrid.grid,
                                  startingGrid: workingGrid.startingGrid,
                                  workingGrid: workingGrid.grid)
                })
                Spacer()
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
                }
            } message: { item in
                Text(item.message)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear() {
            self.resetGrids(for: self.difficulty.level)
        }
    }
    
    private func resetGrids(for level: Difficulty.Level) {
        workingGrid.reset(newGrid: GridFactory.randomGridForDifficulty(level: level))
        selectedCell.coordinate = nil
        userAction.action = .none
        editState.isEditing = false
        editGrid.grid = []
    }
    
    private func save() {
        let gameState = SavedGameState(workingGrid: workingGrid.grid, startingGrid: workingGrid.startingGrid, colorGrid: workingGrid.colorGrid, userAction: userAction.action, selectedCell: selectedCell.coordinate, isEditing: editState.isEditing, editValues: editGrid.grid, difficulty: difficulty.level)

        if let encodedGameState = try? JSONEncoder().encode(gameState) {
            UserDefaults.standard.set(encodedGameState, forKey: SavedGameState.persistenceKey)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(difficulty: .easy))
            .environment(SelectedCell())
            .environment(UserAction())
            .environment(EditState())
            .environment(GridValues(startingGrid: GridFactory.easyGrid))
            .environment(EditGridValues(grid: []))
            .environment(Difficulty(level: .easy))
    }
}
