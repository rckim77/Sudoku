//
//  GameLevelButton.swift
//  Sudoku
//
//  Created by Ray Kim on 7/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct GameLevelButton: View {

    @Binding var gameConfigs: [GameConfig]
    let level: Difficulty.Level
    
    var body: some View {
        Button(action: {
            let startingGrid = GridFactory.randomGridForDifficulty(level: level)
            let gameConfig = GameConfig(savedState: .startedUnsaved,
                                        workingGrid: startingGrid,
                                        startingGrid: startingGrid,
                                        difficulty: level,
                                        elapsedTime: 0)
            gameConfigs.append(gameConfig)
        }) {
            Text(level.localizedName)
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
    }
}

#Preview {
    GameLevelButton(gameConfigs: .constant([]), level: .easy)
}
