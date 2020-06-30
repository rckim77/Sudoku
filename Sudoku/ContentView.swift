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
            NavigationLink(destination: GameView(viewModel: GameViewModel())) {
                Text(gameInProgress ? "Resume Game" : "New Game")
            }
        }
        .environmentObject(SelectedCell())
        .environmentObject(UserAction())
        .environmentObject(EditState())
        .environmentObject(Difficulty(level: .easy))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
            .environmentObject(EditState())
            .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
            .environmentObject(GridValues(grid: GridFactory.easyGrid, startingGrid: GridFactory.easyGrid))
            .environmentObject(EditGridValues(grid: []))
            .environmentObject(Difficulty(level: .easy))
    }
}
