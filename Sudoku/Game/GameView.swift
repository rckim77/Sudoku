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
                        selectedCoordinate: selectedCell.coordinate,
                        isEditing: editState.isEditing)
                HStack(content: {
                    HintButton {
                        Task {
                            do {
                                if let hintMessage = try await viewModel.getHint(grid: workingGrid.grid) {
//                                    alertItem = AlertItem(id: .hintSuccess(message: hintMessage))
                                } else {
                                    alertItem = AlertItem(id: .hintError)
                                }
                            } catch {
                                // show alert .hintError
                            }
                        }
                    }
                    NewGameButton(alert: $alertItem,
                                  editGrid: editGrid.grid,
                                  startingGrid: workingGrid.startingGrid,
                                  workingGrid: workingGrid.grid)
                })
                Spacer()
            }
            .alert(item: $alertItem, content: { item in
                switch item.id {
                case .newGame:
                    return Alert(title: Text("Are you sure?"),
                                 message: Text("If you go back, you will lose your current progress."),
                                 primaryButton: .default(Text("Confirm"), action: {
                                    dismiss()
                                 }),
                                 secondaryButton: .cancel())
                case .completedCorrectly:
                    return Alert(title: Text("Congratulations!"),
                                 message: Text("You've completed the sudoku!"),
                                 dismissButton: .default(Text("Go back"), action: {
                                    dismiss()
                                 }))
                case .completedIncorrectly:
                    return Alert(title: Text("Almost!"),
                                 message: Text("Sorry but that's not quite right."),
                                 dismissButton: .default(Text("Dismiss")))
                case .hintError:
                    return Alert(title: Text("Hint"),
                                 message: Text("Oops! Something went wrong. Try again later."),
                                 dismissButton: .default(Text("Dismiss")))
                }
            })
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
