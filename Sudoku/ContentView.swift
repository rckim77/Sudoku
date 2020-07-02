//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private var difficultyButtonHSpacing: CGFloat {
        16 * (isIpad ? 2.5 : 1)
    }
    
    private var buttonsVSpacing: CGFloat {
        40 * (isIpad ? 1.5 : 1)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: buttonsVSpacing) {
                Text("Sudoku Classic")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                HStack(spacing: difficultyButtonHSpacing) {
                    NavigationLink(destination:
                        GameView(viewModel: GameViewModel(difficulty: .easy))
                            .environmentObject(SelectedCell())
                            .environmentObject(UserAction())
                            .environmentObject(EditState())
                            .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
                            .environmentObject(GridValues(grid: GridFactory.easyGrid, startingGrid: GridFactory.easyGrid))
                            .environmentObject(EditGridValues(grid: []))
                            .environmentObject(Difficulty(level: .easy))
                    ) {
                        Text("Easy")
                    }
                        .menuButtonStyle()
                    NavigationLink(destination:
                        GameView(viewModel: GameViewModel(difficulty: .medium))
                            .environmentObject(SelectedCell())
                            .environmentObject(UserAction())
                            .environmentObject(EditState())
                            .environmentObject(StartingGridValues(grid: GridFactory.mediumGrid))
                            .environmentObject(GridValues(grid: GridFactory.mediumGrid, startingGrid: GridFactory.mediumGrid))
                            .environmentObject(EditGridValues(grid: []))
                            .environmentObject(Difficulty(level: .medium))
                    ) {
                        Text("Medium")
                    }
                        .menuButtonStyle()
                    NavigationLink(destination:
                        GameView(viewModel: GameViewModel(difficulty: .hard))
                            .environmentObject(SelectedCell())
                            .environmentObject(UserAction())
                            .environmentObject(EditState())
                            .environmentObject(StartingGridValues(grid: GridFactory.hardGrid))
                            .environmentObject(GridValues(grid: GridFactory.hardGrid, startingGrid: GridFactory.hardGrid))
                            .environmentObject(EditGridValues(grid: []))
                            .environmentObject(Difficulty(level: .hard))
                    ) {
                        Text("Hard")
                    }
                        .menuButtonStyle()
                }
                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                }
                    .menuButtonStyle()
            }
            .fullBackgroundStyle()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
