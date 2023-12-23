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
    @EnvironmentObject
    private var selectedCell: SelectedCell
    @EnvironmentObject
    private var userAction: UserAction
    @EnvironmentObject
    private var editState: EditState
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editGrid: EditGridValues
    @EnvironmentObject
    private var difficulty: Difficulty
    @State
    private var alertItem: AlertItem?
    @State
    private var alertIsPresented: Bool = false
    
    let viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Color("dynamicBackground")
                    .edgesIgnoringSafeArea(.all)
            VStack(spacing: viewModel.verticalSpacing) {
                SudokuGrid(editGrid: editGrid.grid)
                HStack(spacing: viewModel.modifierButtonsHorizontalSpacing) {
                    ClearButton()
                    EditButton()
                }
                KeysRow(alert: $alertItem,
                        alertIsPresented: $alertIsPresented,
                        selectedCoordinate: selectedCell.coordinate,
                        isEditing: editState.isEditing)
                HStack(content: {
                    HintButton {
                        Task {
                            do {
                                if let hintMessage = try await viewModel.getHint(grid: workingGrid.grid) {
                                    alertItem = .hintSuccess(hint: hintMessage)
                                    alertIsPresented = true
                                } else {
                                    alertItem = .hintError
                                    alertIsPresented = true
                                }
                            } catch {
                                alertItem = .hintError
                                alertIsPresented = true
                            }
                        }
                    }
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
                case .hintSuccess(let hint):
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
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(difficulty: .easy))
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
            .environmentObject(EditState())
            .environmentObject(GridValues(startingGrid: GridFactory.easyGrid))
            .environmentObject(EditGridValues(grid: []))
            .environmentObject(Difficulty(level: .easy))
    }
}
