//
//  GameView.swift
//  Sudoku
//
//  Created by Ray Kim on 6/30/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct GameView: View {

    @Environment(\.presentationMode)
    private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject
    private var selectedCell: SelectedCell
    @EnvironmentObject
    private var userAction: UserAction
    @EnvironmentObject
    private var editState: EditState
    @EnvironmentObject
    private var startingGrid: StartingGridValues
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editGrid: EditGridValues
    @EnvironmentObject
    private var difficulty: Difficulty
    @State
    private var workingGridIsComplete = false
    /// Used to follow through on specific difficulty when a user taps confirm on action sheet to
    /// change difficulty.
    @State
    private var lastTappedDifficultyLevel: Difficulty.Level = .easy
    @State
    private var displayAlertForNewGame = false
    
    let viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: viewModel.verticalSpacing) {
            Grid(startingGrid: startingGrid.grid,
                 workingGrid: workingGrid.grid,
                 editGrid: editGrid.grid,
                 colorGrid: workingGrid.colorGrid)
                .padding(.horizontal, viewModel.horizontalSizeClassPadding)
            HStack(spacing: viewModel.modifierButtonsHorizontalSpacing) {
                ClearButton()
                EditButton()
            }
            KeysRow(gridIsComplete: $workingGridIsComplete, selectedCoordinate: selectedCell.coordinate, isEditing: editState.isEditing)
                .padding(.horizontal, viewModel.horizontalSizeClassPadding)
            NewGameButton(displayAlert: $displayAlertForNewGame,
                          editGridIsEmpty: editGrid.isEmpty,
                          workingGridHasMoreValues: workingGrid.grid.count > startingGrid.grid.count)
            Spacer()
        }
        .fullBackgroundStyle()
        .alert(isPresented: $workingGridIsComplete) {
            Alert(title: Text("Congratulations!"),
                  message: Text("You've completed the sudoku!"),
                  dismissButton: .default(Text("Dismiss")))
        }
        .alert(isPresented: $displayAlertForNewGame) {
            Alert(title: Text("You're currently in progress"),
                  message: Text("Are you sure you want to start a new game? You will lose your current progress."),
                  primaryButton: .default(Text("Confirm"), action: {
                    self.presentationMode.wrappedValue.dismiss()
                    self.resetGrids(for: self.difficulty.level)
                  }),
                  secondaryButton: .cancel())
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func resetGrids(for level: Difficulty.Level) {
        startingGrid.reset(newGrid: GridFactory.gridForDifficulty(level: level))
        workingGrid.reset(newGrid: GridFactory.gridForDifficulty(level: level))
        selectedCell.coordinate = nil
        userAction.action = .none
        editState.isEditing = false
        editGrid.grid = []
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(difficulty: .easy))
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
            .environmentObject(EditState())
            .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
            .environmentObject(GridValues(grid: GridFactory.easyGrid, startingGrid: GridFactory.easyGrid))
            .environmentObject(EditGridValues(grid: []))
            .environmentObject(Difficulty(level: .easy))
    }
}
