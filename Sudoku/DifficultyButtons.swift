//
//  DifficultyButtons.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct DifficultyButtons: View {
    @Binding
    var displayAlert: Bool
    @Binding
    var lastTappedDifficulty: Difficulty.Level
    let editGridIsEmpty: Bool
    let workingGridHasMoreValues: Bool
    let currentLevel: Difficulty.Level

    var body: some View {
        HStack(spacing: isIpad ? 36 : 12) {
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             viewModel: DifficultyButtonViewModel(buttonLevel: .easy,
                                                                  currentLevel: currentLevel,
                             editGridIsEmpty: editGridIsEmpty, workingGridHasMoreValues: workingGridHasMoreValues))
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             viewModel: DifficultyButtonViewModel(buttonLevel: .medium,
                                                                  currentLevel: currentLevel,
                             editGridIsEmpty: editGridIsEmpty, workingGridHasMoreValues: workingGridHasMoreValues))
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             viewModel: DifficultyButtonViewModel(buttonLevel: .hard,
                                                                  currentLevel: currentLevel,
                             editGridIsEmpty: editGridIsEmpty, workingGridHasMoreValues: workingGridHasMoreValues))
        }
    }
}

struct DifficultyButtons_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButtons(displayAlert: .constant(false),
                          lastTappedDifficulty: .constant(.easy),
                          editGridIsEmpty: true,
                          workingGridHasMoreValues: true,
                          currentLevel: .easy)
    }
}
