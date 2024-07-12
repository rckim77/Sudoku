//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct GameLevelNavigationLink: View {
    
    let level: Difficulty.Level
    /// By using a State property wrapper to persist the grid once we create it in the init function,
    /// we avoid a bug where the grid keeps refreshing to a random grid for each user action.
    @State private var grid: GridValues
    
    init(level: Difficulty.Level) {
        _grid = State(wrappedValue: GridValues(startingGrid: GridFactory.randomGridForDifficulty(level: level)))
        self.level = level
    }
    
    var body: some View {
        NavigationLink {
            GameView(viewModel: GameViewModel(difficulty: level))
                .environment(grid)
                .environment(EditGridValues(grid: []))
        } label: {
            Text(level.rawValue)
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
    }
}

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
                                     viewModel: GameViewModel(difficulty: savedGameState.difficulty))
                                .environment(GridValues(grid: savedGameState.workingGrid, startingGrid: savedGameState.startingGrid, colorGrid: savedGameState.colorGrid))
                                .environment(EditGridValues(grid: savedGameState.editValues))
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
