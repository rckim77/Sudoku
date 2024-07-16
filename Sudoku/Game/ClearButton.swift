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

    var body: some View {
        Button(action: {
            self.userAction.action = .clear

            guard let selectedCoordinate = self.selectedCoordinate,
                  !self.workingGrid.containsAValue(at: selectedCoordinate, grid: workingGrid.startingGrid) else {
                // can't clear values that were part of starting board and unselected
                return
            }

            // clear guesses regardless of editing mode
            self.editGrid.removeValues(at: selectedCoordinate)

            if !self.editState.isEditing {
                self.workingGrid.removeValue(at: selectedCoordinate)
            }
        }) {
            Text("Clear")
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(textColor: Color.black, backgroundColor: Color("dynamicGray"))
    }
}

#Preview {
    ClearButton(selectedCoordinate: nil, editGrid: EditGridValues(grid: []), editState: EditState(isEditing: false), userAction: UserAction(), workingGrid: GridValues(startingGrid: GridFactory.easyGrid))
}
