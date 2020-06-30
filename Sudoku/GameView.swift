//
//  GameView.swift
//  Sudoku
//
//  Created by Ray Kim on 6/30/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject
    private var selectedCell: SelectedCell
    @EnvironmentObject
    private var userAction: UserAction
    @EnvironmentObject
    private var editState: EditState
    @EnvironmentObject
    private var startingGrid: StartingGridValues
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editGrid: EditGridValues
    @EnvironmentObject
    private var difficulty: Difficulty
    @State
    private var workingGridIsComplete = false
    /// Used to follow through on specific difficulty when a user taps confirm on action sheet to
    /// change difficulty.
    @State
    private var lastTappedDifficultyLevel: Difficulty.Level = .easy
    @State
    private var displayAlertForDifficultyChange = false
    
    let viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: viewModel.verticalSpacing) {
            Grid(startingGrid: startingGrid.grid,
                 workingGrid: workingGrid.grid,
                 editGrid: editGrid.grid,
                 colorGrid: workingGrid.colorGrid)
                .padding(.horizontal, viewModel.horizontalSizeClassPadding)
            HStack(spacing: viewModel.modifierButtonsHorizontalSpacing) {
                ClearButton()
                EditButton()
            }
            KeysRow(gridIsComplete: $workingGridIsComplete, selectedCoordinate: selectedCell.coordinate, isEditing: editState.isEditing)
                .padding(.horizontal, viewModel.horizontalSizeClassPadding)
            DifficultyButtons(displayAlert: $displayAlertForDifficultyChange,
                              lastTappedDifficulty: $lastTappedDifficultyLevel,
                              editGridIsEmpty: editGrid.grid.isEmpty,
                              workingGridHasMoreValues: workingGrid.grid.count > startingGrid.grid.count,
                              currentLevel: difficulty.level)
        }
        .alert(isPresented: $workingGridIsComplete) {
            Alert(title: Text("Congratulations!"),
                  message: Text("You've completed the sudoku!"),
                  dismissButton: .default(Text("Dismiss")))
        }
        .alert(isPresented: $displayAlertForDifficultyChange) {
            Alert(title: Text("You're currently in progress"),
                  message: Text("Are you sure you want to change difficulty? This will reset your progress on the current board."),
                  primaryButton: .default(Text("Confirm"), action: {
                    guard self.lastTappedDifficultyLevel != self.difficulty.level else {
                        return
                    }
                    self.difficulty.level = self.lastTappedDifficultyLevel
                    let newGrid = GridFactory.gridForDifficulty(level: self.difficulty.level)
                    self.startingGrid.reset(newGrid: newGrid)
                    self.workingGrid.reset(newGrid: newGrid)
                    self.editGrid.grid = []
                    self.selectedCell.coordinate = nil
                  }),
                  secondaryButton: .cancel())
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
