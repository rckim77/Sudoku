//
//  GameLevelButton.swift
//  Sudoku
//
//  Created by Ray Kim on 7/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct GameLevelButton: View {
    
    @Binding var isLoading: Bool
    @Binding var gameConfigs: [GameConfig]
    let level: Difficulty.Level
    
    var body: some View {
        Button(action: {
            Task {
                isLoading = true
                guard let board = try? await API.generateSudokuBoard(difficulty: level) else {
                    isLoading = false
                    let startingGrid = GridFactory.randomGridForDifficulty(level: level)
                    let gameConfig = GameConfig(savedState: .startedUnsaved, workingGrid: startingGrid, startingGrid: startingGrid, difficulty: level)
                    gameConfigs.append(gameConfig)
                    return
                }
                
                isLoading = false
                let gameConfig = GameConfig(savedState: .startedUnsaved, workingGrid: board, startingGrid: board, difficulty: level)
                gameConfigs.append(gameConfig)
            }
        }) {
            Text(isLoading ? "Generating" : level.rawValue)
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
        .animation(.easeInOut, value: isLoading)
    }
}

#Preview {
    GameLevelButton(isLoading: .constant(false), gameConfigs: .constant([]), level: .easy)
}
