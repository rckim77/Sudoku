//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject
    private var startingGrid: StartingGridValues
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editGrid: EditGridValues
    
    private var gameInProgress: Bool {
        workingGrid.grid.count > startingGrid.grid.count || !editGrid.grid.isEmpty
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("dynamicBackground")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 40) {
                    Text("Sudoku Classic")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                    HStack(spacing: 16) {
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
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(SelectedCell())
        .environmentObject(UserAction())
        .environmentObject(EditState())
        .environmentObject(Difficulty(level: .easy))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
                .environmentObject(GridValues(grid: GridFactory.easyGrid, startingGrid: GridFactory.easyGrid))
                .environmentObject(EditGridValues(grid: []))
        }
    }
}
