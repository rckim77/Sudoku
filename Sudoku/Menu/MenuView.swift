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
    @State var gameConfigs: [GameConfig] = []
    
    var body: some View {
        NavigationStack(path: $gameConfigs) {
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
                            GameLevelButton(gameConfigs: $gameConfigs, level: level)
                        }
                    }
                }
                MenuNavigationLinks()
            }
            .fullBackgroundStyle()
            .navigationDestination(for: GameConfig.self) { gameConfig in
                GameView(gameConfig)
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
