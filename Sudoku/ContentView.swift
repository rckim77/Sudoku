//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    private let viewModel = ContentViewModel()
    @Query var savedGameState: [SavedGameState]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: viewModel.buttonsVSpacing) {
                Text("Sudoku AI")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                VStack(spacing: viewModel.savedGameVSpacing) {
                    if let savedGameState = savedGameState.first {
                        NavigationLink {
                            GameView(savedState: .startedSaved,
                                     selectedCell: SelectedCell(coordinate: savedGameState.selectedCell),
                                     userAction: UserAction(action: savedGameState.userAction),
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
                MenuNavigationLinks()
            }
            .fullBackgroundStyle()
        }
    }
}

#Preview {
    GeometryReader { geometry in
        ContentView()
            .environment(WindowSize(size: geometry.size))
    }
}
