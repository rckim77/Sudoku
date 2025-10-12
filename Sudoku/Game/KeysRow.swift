//
//  KeysRow.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct KeysRow: View {

    var editGrid: EditGridValues
    var userAction: UserAction
    var workingGrid: GridValues

    @Binding var alert: AlertItem?
    @Binding var alertIsPresented: Bool
    
    let selectedCoordinate: Coordinate?
    let isEditing: Bool
    let isCompact: Bool
    
    @Binding var savedState: SavedState

    var undoManager: UndoManager

    private let buttonCornerRadius: CGFloat = 16
    private var horizontalSpacing: CGFloat {
        isIphone ? 8 : 32
    }

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: horizontalSpacing)
            HStack(spacing: 2) {
                ForEach((1...9), id: \.self) { digit in
                    Button(action: {
                        self.updateForDigit(digit)
                    }) {
                        KeysRowButtonText(text: "\(digit)", isCompact: isCompact)
                    }
                    .buttonStyle(.plain)
                    .background(Color("dynamicGray"))
                    .clipShape(clipShape)
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
                .frame(width: horizontalSpacing)
        }
    }
    
    private var clipShape: AnyShape {
        if isVision {
            AnyShape(Capsule())
        } else {
            AnyShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
        }
    }

    private func updateForDigit(_ digit: Int) {
        guard let selectedCoordinate = selectedCoordinate,
              !workingGrid.containsAValue(at: selectedCoordinate, grid: workingGrid.startingGrid) else {
            return
        }
        
        if isEditing {
            // For edit mode, track each individual pencil mark change
            let currentGuesses = editGrid.guesses(for: selectedCoordinate)?.values ?? Set()
            if currentGuesses.contains(digit) {
                // Removing a pencil mark
                trackUndoAction(at: selectedCoordinate, action: .remove(digit: digit))
            } else {
                // Adding a pencil mark
                trackUndoAction(at: selectedCoordinate, action: .add(digit: digit))
            }
            editGrid.updateGuesses(value: digit, at: selectedCoordinate)
            savedState = .unsaved
            userAction.action = .digit(digit)
        } else {
            // For normal mode, only track if we're changing the value
            let currentValue = workingGrid.getValue(at: selectedCoordinate, grid: workingGrid.grid)
            if currentValue != digit {
                trackUndoAction(at: selectedCoordinate, action: .none)
                editGrid.removeValues(at: selectedCoordinate)
                
                let coordinateValue = CoordinateValue(r: selectedCoordinate.r,
                                                    c: selectedCoordinate.c,
                                                    s: selectedCoordinate.s,
                                                    v: digit)
                workingGrid.add(coordinateValue)
                savedState = .unsaved
                userAction.action = .digit(digit)
                
                if workingGrid.grid.count == 81 {
                    if workingGrid.isSolved {
                        alert = .completedCorrectly
                        alertIsPresented = true
                    } else {
                        alert = .completedIncorrectly
                        alertIsPresented = true
                    }
                }
            }
        }
    }
    
    private func trackUndoAction(at coordinate: Coordinate, action: EditActionType) {
        let previousValue = workingGrid.getValue(at: coordinate, grid: workingGrid.grid)
        let previousEditValues = editGrid.guesses(for: coordinate)?.values ?? Set()
        
        undoManager.addAction(UndoAction(
            coordinate: coordinate,
            previousValue: previousValue,
            previousEditValues: previousEditValues,
            wasEditing: isEditing,
            editActionType: action
        ))
    }
}

#Preview {
    KeysRow(editGrid: EditGridValues(grid: []),
            userAction: UserAction(),
            workingGrid: GridValues(startingGrid: GridFactory.easyGrid),
            alert: .constant(.completedCorrectly),
            alertIsPresented: .constant(false),
            selectedCoordinate: nil,
            isEditing: false,
            isCompact: false,
            savedState: .constant(.unsaved),
            undoManager: UndoManager())
}
