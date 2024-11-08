//
//  ClearButton.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ClearButton: View {

    let selectedCoordinate: Coordinate?
    var editGrid: EditGridValues
    var editState: EditState
    var userAction: UserAction
    var workingGrid: GridValues
    @Binding var savedState: SavedState
    var undoManager: UndoManager

    var body: some View {
        Button("Clear", systemImage: "eraser") {
            guard let selectedCoordinate = self.selectedCoordinate,
                  !self.workingGrid.containsAValue(at: selectedCoordinate, grid: workingGrid.startingGrid) else {
                return
            }
            
            // Only track the action if there's something to clear
            let hasValue = workingGrid.getValue(at: selectedCoordinate, grid: workingGrid.grid) != nil
            let hasGuesses = !(editGrid.guesses(for: selectedCoordinate)?.values.isEmpty ?? true)
            
            if hasValue || hasGuesses {
                let previousValue = workingGrid.getValue(at: selectedCoordinate, grid: workingGrid.grid)
                let previousEditValues = editGrid.guesses(for: selectedCoordinate)?.values ?? Set()
                
                undoManager.addAction(UndoAction(
                    coordinate: selectedCoordinate,
                    previousValue: previousValue,
                    previousEditValues: previousEditValues,
                    wasEditing: editState.isEditing,
                    editActionType: .none
                ))
                
                self.savedState = .unsaved
                self.userAction.action = .clear
                
                // clear guesses regardless of editing mode
                self.editGrid.removeValues(at: selectedCoordinate)
                
                if !self.editState.isEditing {
                    self.workingGrid.removeValue(at: selectedCoordinate)
                }
            }
        }
        .tint(.primary)
    }
}
