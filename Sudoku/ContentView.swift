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

    var buttonVerticalPadding: CGFloat {
        if isLargestIpad {
            return 24
        } else if isIpad {
            return 20
        } else {
            return 10
        }
    }

    var buttonHorizontalPadding: CGFloat {
        if isLargestIpad {
            return 38
        } else if isIpad {
            return 32
        } else {
            return 16
        }
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
                    NavigationLink(destination: GameView(viewModel: GameViewModel())) {
                        Text(gameInProgress ? "Resume Game" : "New Game")
                    }
                        .padding(.vertical, buttonVerticalPadding)
                        .padding(.horizontal, buttonHorizontalPadding)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                    }
                        .padding(.vertical, buttonVerticalPadding)
                        .padding(.horizontal, buttonHorizontalPadding)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
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
        Group {
            ContentView()
                .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
                .environmentObject(GridValues(grid: GridFactory.easyGrid, startingGrid: GridFactory.easyGrid))
                .environmentObject(EditGridValues(grid: []))
            ContentView()
                .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
                .environmentObject(GridValues(grid: GridFactory.easyGrid, startingGrid: GridFactory.easyGrid))
                .environmentObject(EditGridValues(grid: []))
                .environment(\.colorScheme, .dark)
        }
    }
}
