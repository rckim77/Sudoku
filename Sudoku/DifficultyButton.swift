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

    let level: Difficulty.Level

    var body: some View {
        Button(action: {
            self.difficulty.level = self.level
        }) {
            Text(level.rawValue)
                .foregroundColor(level == difficulty.level ? .white : Color.blue)
        }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(level == difficulty.level ? Color.blue.opacity(0.9) : Color.blue.opacity(0.2))
            .cornerRadius(8)
    }
}

struct DifficultyButton_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButton(level: .easy)
    }
}
