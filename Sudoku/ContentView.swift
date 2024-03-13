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
}

#Preview {
    ContentView()
}
