//
//  GameLevelNavigationLink.swift
//  Sudoku
//
//  Created by Ray Kim on 7/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct GameLevelNavigationLink: View {
    
    let level: Difficulty.Level
    
    var body: some View {
        NavigationLink {
            GameView(workingGrid: GridValues(startingGrid: GridFactory.randomGridForDifficulty(level: level)),
                     viewModel: GameViewModel(difficulty: level))
        } label: {
            Text(level.rawValue)
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
    }
}
