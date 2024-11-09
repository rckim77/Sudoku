//
//  MenuView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import SwiftData

struct MenuView: View {
    
    private let viewModel = MenuViewModel()
    @Query var savedGameState: [GameConfig]
    @State private var gameState: [GameConfig] = []
    
    var body: some View {
        NavigationStack(path: $gameState) {
            VStack(spacing: viewModel.buttonsVSpacing) {
                Text("Sudoku AI")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                VStack(spacing: viewModel.savedGameVSpacing) {
                    if let savedGameState = savedGameState.first {
                        NavigationLink(value: savedGameState) {
                            Text("Continue game")
                                .font(.system(.headline, design: .rounded))
                        }
                        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
                    }
                    HStack(spacing: viewModel.difficultyButtonHSpacing) {
                        ForEach(viewModel.difficultyLevels, id: \.self) { level in
                            let startingGrid = GridFactory.randomGridForDifficulty(level: level)
                            let gameConfig = GameConfig(savedState: .startedUnsaved, workingGrid: startingGrid, startingGrid: startingGrid, colorGrid: [], userAction: .none, selectedCell: nil, isEditing: false, editValues: [], difficulty: level)
                            NavigationLink(value: gameConfig) {
                                Text(level.rawValue)
                                    .font(.system(.headline, design: .rounded))
                            }
                            .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
                        }
                    }
                }
                MenuNavigationLinks()
            }
            .fullBackgroundStyle()
            .navigationDestination(for: GameConfig.self) { gameConfig in
                let selectedCell = SelectedCell(coordinate: gameConfig.selectedCell)
                let userAction = UserAction(action: gameConfig.userAction)
                let editState = EditState(isEditing: gameConfig.isEditing)
                let workingGrid = GridValues(grid: gameConfig.workingGrid, startingGrid: gameConfig.startingGrid, colorGrid: gameConfig.colorGrid)
                let editGrid = EditGridValues(grid: gameConfig.editValues)
                let viewModel = GameViewModel(difficulty: gameConfig.difficulty)
                GameView(savedState: gameConfig.savedState,
                         selectedCell: selectedCell,
                         userAction: userAction,
                         editState: editState,
                         workingGrid: workingGrid,
                         editGrid: editGrid,
                         viewModel: viewModel)
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        MenuView()
            .environment(WindowSize(size: geometry.size))
    }
}
