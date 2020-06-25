//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.horizontalSizeClass)
    var horizontalClass
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

    private var verticalSpacing: CGFloat {
        guard !isIpad else {
            return 50
        }

        if screenHeight > 736 { // taller than 8 Plus
            return 48
        } else if screenHeight > 667 { // 8 Plus
            return 26
        } else { // 8, SE (2nd gen)
            return 20
        }
    }

    private var clearButtonHorizontalPadding: CGFloat {
        if screenHeight > 736 { // taller than 8 Plus
            return 22
        } else { // 8 Plus, 8, SE (2nd gen)
            return 14
        }
    }

    private var clearButtonVerticalPadding: CGFloat {
        if screenHeight > 736 { // taller than 8 Plus
            return 10
        } else { // 8 Plus, 8, SE (2nd gen)
            return 8
        }
    }

    private var gridHorizontalPadding: CGFloat {
        if isLargestIpad {
            return 175
        } else {
            return horizontalSizeClassPadding
        }
    }

    private var horizontalSizeClassPadding: CGFloat {
        return horizontalClass == .regular ? 80 : 0
    }

    var body: some View {
        VStack(spacing: verticalSpacing) {
            Grid(startingGrid: startingGrid.grid, workingGrid: workingGrid.grid, editGrid: editGrid.grid)
                .padding(.horizontal, gridHorizontalPadding)
            HStack(spacing: isIpad ? 36 : 12) {
                ClearButton()
                EditButton()
            }
            KeysRow(gridIsComplete: $workingGridIsComplete, selectedCoordinate: selectedCell.coordinate, isEditing: editState.isEditing)
                .padding(.horizontal, horizontalSizeClassPadding)
            DifficultyButtons(displayAlert: $displayAlertForDifficultyChange,
                              lastTappedDifficulty: $lastTappedDifficultyLevel,
                              editGridIsEmpty: editGrid.grid.isEmpty)
        }
        .alert(isPresented: $workingGridIsComplete) {
            Alert(title: Text("Congratulations!"),
                  message: Text("You've completed the sudoku!"),
                  dismissButton: .default(Text("Dismiss")))
        }
        .actionSheet(isPresented: $displayAlertForDifficultyChange) {
            ActionSheet(title: Text("You're currently in progress"),
                        message: Text("Are you sure you want to change difficulty? This will reset your progress on the current board."),
                        buttons: [.cancel(), .destructive(Text("Confirm"),
                        action: {
                            guard self.lastTappedDifficultyLevel != self.difficulty.level else {
                                return
                            }
                            self.difficulty.level = self.lastTappedDifficultyLevel
                            let newGrid = GridFactory.gridForDifficulty(level: self.difficulty.level)
                            self.startingGrid.reset(newGrid: newGrid)
                            self.workingGrid.reset(newGrid: newGrid)
                            self.editGrid.grid = []
                            self.selectedCell.coordinate = nil
            })])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
            .environmentObject(EditState())
            .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
            .environmentObject(GridValues(grid: GridFactory.easyGrid))
            .environmentObject(EditGridValues(grid: []))
            .environmentObject(Difficulty(level: .easy))
    }
}
