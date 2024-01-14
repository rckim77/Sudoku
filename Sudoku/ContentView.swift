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
        NavigationView {
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
                NavigationLink {
                    SettingsView()
                } label: {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .font(.system(.headline, design: .rounded))
                .tint(Color("dynamicDarkGray"))
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
