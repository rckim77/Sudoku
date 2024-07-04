//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private let viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: viewModel.buttonsVSpacing) {
                Text("Sudoku AI")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                VStack(spacing: 16) {
                    if let savedGameState = getSavedGameState() {
                        NavigationLink {
                            GameView(viewModel: GameViewModel(difficulty: .easy))
                                .environmentObject(SelectedCell(coordinate: savedGameState.selectedCell))
                                .environmentObject(UserAction(action: savedGameState.userAction ?? .none))
                                .environmentObject(EditState(isEditing: savedGameState.isEditing))
                                .environmentObject(GridValues(startingGrid: savedGameState.workingGrid))
                                .environmentObject(EditGridValues(grid: savedGameState.editValues))
                                .environmentObject(Difficulty(level: savedGameState.difficulty))
                        } label: {
                            Text("Continue game")
                                .font(.system(.headline, design: .rounded))
                        }
                        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
                    }
                    HStack(spacing: viewModel.difficultyButtonHSpacing) {
                        ForEach(viewModel.difficultyLevels, id: \.self) { level in
                            NavigationLink {
                                GameView(viewModel: GameViewModel(difficulty: level))
                                    .environmentObject(SelectedCell())
                                    .environmentObject(UserAction())
                                    .environmentObject(EditState())
                                    .environmentObject(GridValues(startingGrid: GridFactory.randomGridForDifficulty(level: level)))
                                    .environmentObject(EditGridValues(grid: []))
                                    .environmentObject(Difficulty(level: level))
                            } label: {
                                Text(level.rawValue)
                                    .font(.system(.headline, design: .rounded))
                            }
                            .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
                        }
                    }
                }
                VStack(spacing: 18) {
                    NavigationLink {
                        HowToPlayView()
                    } label: {
                        Label("How to play", systemImage: "questionmark.circle")
                            .font(.system(.headline, design: .rounded))
                            .tint(Color("dynamicDarkGray"))
                    }
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Label("Settings", systemImage: "gear")
                            .font(.system(.headline, design: .rounded))
                            .tint(Color("dynamicDarkGray"))
                    }
                }
            }
            .fullBackgroundStyle()
        }
    }
    
    private func getSavedGameState() -> SavedGameState? {
        guard let data = UserDefaults.standard.data(forKey: SavedGameState.persistenceKey),
              let gameState = try? JSONDecoder().decode(SavedGameState.self, from: data) else {
            return nil
        }
        return gameState
    }
}

#Preview {
    ContentView()
}
