//
//  DifficultyButton.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/18/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct DifficultyButton: View {

    @EnvironmentObject
    private var difficulty: Difficulty
    @EnvironmentObject
    private var startingGrid: StartingGridValues
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editGrid: EditGridValues
    @EnvironmentObject
    private var selectedCell: SelectedCell
    @Binding
    var displayAlert: Bool
    @Binding
    var lastTappedDifficulty: Difficulty.Level

    let level: Difficulty.Level

    private var buttonVerticalPadding: CGFloat {
        if isLargestIpad {
            return 24
        } else if isIpad {
            return 20
        } else {
            return 10
        }
    }

    private var buttonHorizontalPadding: CGFloat {
        if isLargestIpad {
            return 38
        } else if isIpad {
            return 32
        } else {
            return 16
        }
    }

    var body: some View {
        Button(action: {
            guard self.level != self.difficulty.level else {
                return
            }
            self.lastTappedDifficulty = self.level
            if self.workingGrid.grid.count != self.startingGrid.grid.count || !self.editGrid.grid.isEmpty {
                self.displayAlert = true
            } else {
                self.difficulty.level = self.level
                let newGrid = GridFactory.gridForDifficulty(level: self.difficulty.level)
                self.startingGrid.reset(newGrid: newGrid)
                self.workingGrid.reset(newGrid: newGrid)
                self.selectedCell.coordinate = nil
            }
        }) {
            Text(level.rawValue)
                .foregroundColor(level == difficulty.level ? .white : Color.blue)
        }
            .padding(.vertical, buttonVerticalPadding)
            .padding(.horizontal, buttonHorizontalPadding)
            .background(level == difficulty.level ? Color.blue.opacity(0.9) : Color.blue.opacity(0.2))
            .cornerRadius(8)
    }
}

// test
struct DifficultyButton_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButton(displayAlert: .constant(false), lastTappedDifficulty: .constant(.easy), level: .easy)
    }
}
