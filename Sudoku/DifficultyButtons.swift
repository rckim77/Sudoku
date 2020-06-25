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

    var body: some View {
        HStack(spacing: isIpad ? 36 : 12) {
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             level: .easy,
                             editGridIsEmpty: editGridIsEmpty)
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             level: .medium,
                             editGridIsEmpty: editGridIsEmpty)
            DifficultyButton(displayAlert: $displayAlert,
                             lastTappedDifficulty: $lastTappedDifficulty,
                             level: .hard,
                             editGridIsEmpty: editGridIsEmpty)
        }
    }
}

struct DifficultyButtons_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButtons(displayAlert: .constant(false), lastTappedDifficulty: .constant(.easy), editGridIsEmpty: true)
    }
}
