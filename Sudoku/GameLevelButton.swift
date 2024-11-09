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

    @State private var task: Task<Void, Never>? = nil

    private let sleepDuration: UInt64 = 7 * 1_000_000_000 // 7 seconds
    
    var body: some View {
        Button(action: {
            // cancel taps while loading
            guard task == nil else { return }

            task = Task {
                defer {
                    self.task = nil
                }
                // load sudoku board with timeout (this works because of the task group type and the next() method)
                do {
                    let board = try await withThrowingTaskGroup(of: [CoordinateValue].self) { group in
                        group.addTask {
                            return try await API.generateSudokuBoard(difficulty: level)
                        }
                        group.addTask {
                            try await Task.sleep(nanoseconds: sleepDuration)
                            throw CancellationError()
                        }

                        guard let result = try await group.next() else {
                            group.cancelAll()
                            throw CancellationError()
                        }
                        group.cancelAll()
                        return result
                    }
                    let gameConfig = GameConfig(savedState: .startedUnsaved, workingGrid: board, startingGrid: board, difficulty: level)
                    gameConfigs.append(gameConfig)
                } catch {
                    let startingGrid = GridFactory.randomGridForDifficulty(level: level)
                    let gameConfig = GameConfig(savedState: .startedUnsaved, workingGrid: startingGrid, startingGrid: startingGrid, difficulty: level)
                    gameConfigs.append(gameConfig)
                }
            }
        }) {
            Text(task != nil ? "Generating" : level.rawValue)
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
        .animation(.easeInOut, value: task)
    }
}

#Preview {
    GameLevelButton(gameConfigs: .constant([]), level: .easy)
}
