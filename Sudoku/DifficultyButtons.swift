//
//  DifficultyButtons.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct DifficultyButtons: View {

    @EnvironmentObject
    private var difficulty: Difficulty
    private var level: Difficulty.Level {
        difficulty.level
    }

    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                self.difficulty.level = .easy
            }) {
                Text(Difficulty.Level.easy.rawValue)
                    .foregroundColor(level == .easy ? .white : Color.blue)
            }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(level == .easy ? Color.blue.opacity(0.9) : Color.blue.opacity(0.2))
                .cornerRadius(8)
            Button(action: {
                self.difficulty.level = .medium
            }) {
                Text(Difficulty.Level.medium.rawValue)
                    .foregroundColor(level == .medium ? .white : Color.blue)
            }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(level == .medium ? Color.blue.opacity(0.9) : Color.blue.opacity(0.2))
                .cornerRadius(8)
            Button(action: {
                self.difficulty.level = .hard
            }) {
                Text(Difficulty.Level.hard.rawValue)
                    .foregroundColor(level == .hard ? .white : Color.blue)
            }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(level == .hard ? Color.blue.opacity(0.9) : Color.blue.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

struct DifficultyButtons_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButtons()
            .environmentObject(Difficulty(level: .easy))
    }
}
