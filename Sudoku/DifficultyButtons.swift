//
//  DifficultyButtons.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct DifficultyButtons: View {
    var body: some View {
        HStack(spacing: 12) {
            DifficultyButton(level: .easy)
            DifficultyButton(level: .medium)
            DifficultyButton(level: .hard)
        }
    }
}

struct DifficultyButtons_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButtons()
    }
}
