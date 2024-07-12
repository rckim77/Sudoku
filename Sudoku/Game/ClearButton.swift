//
//  ClearButton.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ClearButton: View {
    @Environment(GridValues.self) private var workingGrid: GridValues
    let selectedCoordinate: Coordinate?
    var editGrid: EditGridValues
    var editState: EditState
    var userAction: UserAction

    private var horizontalPadding: CGFloat {
        guard !isIpad else {
            return 28
        }
        if screenHeight > 736 { // taller than 8 Plus
            return 22
        } else { // 8 Plus, 8, SE (2nd gen)
            return 14
        }
    }

    private var verticalPadding: CGFloat {
        guard !isIpad else {
            return 20
        }
        return 0
    }

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
