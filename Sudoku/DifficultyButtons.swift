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

    var body: some View {
        HStack(spacing: isIpad ? 36 : 12) {
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             viewModel: DifficultyButtonViewModel(level: .easy,
                             editGridIsEmpty: editGridIsEmpty, workingGridHasMoreValues: workingGridHasMoreValues))
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             viewModel: DifficultyButtonViewModel(level: .medium,
                             editGridIsEmpty: editGridIsEmpty, workingGridHasMoreValues: workingGridHasMoreValues))
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             viewModel: DifficultyButtonViewModel(level: .hard,
                             editGridIsEmpty: editGridIsEmpty, workingGridHasMoreValues: workingGridHasMoreValues))
        }
    }
}

struct DifficultyButtons_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButtons(displayAlert: .constant(false), lastTappedDifficulty: .constant(.easy), editGridIsEmpty: true, workingGridHasMoreValues: true)
    }
}
