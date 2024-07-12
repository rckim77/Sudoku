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
                            GameView(selectedCell: SelectedCell(coordinate: savedGameState.selectedCell),
                                     userAction: UserAction(action: savedGameState.userAction ?? .none),
                                     editState: EditState(isEditing: savedGameState.isEditing),
                                     workingGrid: GridValues(grid: savedGameState.workingGrid, startingGrid: savedGameState.startingGrid, colorGrid: savedGameState.colorGrid),
                                     editGrid: EditGridValues(grid: savedGameState.editValues),
                                     viewModel: GameViewModel(difficulty: savedGameState.difficulty))
                        } label: {
                            Text("Continue game")
                                .font(.system(.headline, design: .rounded))
                        }
                        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
                    }
                    HStack(spacing: viewModel.difficultyButtonHSpacing) {
                        ForEach(viewModel.difficultyLevels, id: \.self) { level in
                            GameLevelNavigationLink(level: level)
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
