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
    
    private let difficultyLevels: [Difficulty.Level] = [.easy, .medium, .hard]
    
    var body: some View {
        NavigationView {
            VStack(spacing: buttonsVSpacing) {
                Text("Sudoku Classic")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                HStack(spacing: difficultyButtonHSpacing) {
                    ForEach(difficultyLevels, id: \.self) { level in
                        NavigationLink(destination:
                            GameView(viewModel: GameViewModel(difficulty: level))
                                .environmentObject(SelectedCell())
                                .environmentObject(UserAction())
                                .environmentObject(EditState())
                                .environmentObject(StartingGridValues(grid: GridFactory.gridForDifficulty(level: level)))
                                .environmentObject(GridValues(grid: GridFactory.gridForDifficulty(level: level),
                                                              startingGrid: GridFactory.gridForDifficulty(level: level)))
                                .environmentObject(EditGridValues(grid: []))
                                .environmentObject(Difficulty(level: level))
                        ) {
                            Text(level.rawValue)
                        }
                        .menuButtonStyle()
                    }
                }
                NavigationLink(destination: SettingsView()) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .accentColor(Color("dynamicDarkGray"))
                
            }
            .fullBackgroundStyle()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice(PreviewDevice(rawValue: "iPad (7th generation)"))
            .environment(\.colorScheme, .dark)
    }
}
