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
    private var selectedCell: SelectedCell
    @Binding
    var displayAlert: Bool
    @Binding
    var lastTappedDifficulty: Difficulty.Level

    let viewModel: DifficultyButtonViewModel

    var body: some View {
        Button(action: {
            guard self.viewModel.level != self.difficulty.level else {
                return
            }
            self.lastTappedDifficulty = self.viewModel.level
            if self.viewModel.shouldDisplayAlert {
                self.displayAlert = true
            } else {
                self.difficulty.level = self.viewModel.level
                let newGrid = GridFactory.gridForDifficulty(level: self.difficulty.level)
                self.startingGrid.reset(newGrid: newGrid)
                self.workingGrid.reset(newGrid: newGrid)
                self.selectedCell.coordinate = nil
            }
        }) {
            Text(viewModel.level.rawValue)
                .foregroundColor(viewModel.level == difficulty.level ? .white : Color.blue)
        }
        .padding(.vertical, viewModel.buttonVerticalPadding)
        .padding(.horizontal, viewModel.buttonHorizontalPadding)
        .background(viewModel.level == difficulty.level ? Color.blue.opacity(0.9) : Color.blue.opacity(0.2))
            .cornerRadius(8)
    }
}

struct DifficultyButton_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButton(displayAlert: .constant(false),
                         lastTappedDifficulty: .constant(.easy),
                         viewModel: DifficultyButtonViewModel(level: .easy,
                                                              editGridIsEmpty: false,
                                                              workingGridHasMoreValues: true))
    }
}
