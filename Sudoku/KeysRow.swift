//
//  KeysRow.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct KeysRow: View {

    @EnvironmentObject
    private var userAction: UserAction
    // Note: startingGrid and workingGrid need to be different types in order for @EnvironmentObject to work properly
    // Reference: https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-environmentobject-property-wrapper
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var startingGrid: StartingGridValues
    @EnvironmentObject
    private var editGrid: EditGridValues
    @Binding
    var gridIsComplete: Bool
    
    let selectedCoordinate: Coordinate?
    let isEditing: Bool

    private let buttonCornerRadius: CGFloat = 5

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            HStack(spacing: 2) {
                Button(action: {
                    self.updateForDigit(1)
                }) {
                    KeysRowButtonText(text: "1")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(2)
                }) {
                    KeysRowButtonText(text: "2")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(3)
                }) {
                    KeysRowButtonText(text: "3")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(4)
                }) {
                    KeysRowButtonText(text: "4")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(5)
                }) {
                    KeysRowButtonText(text: "5")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(6)
                }) {
                    KeysRowButtonText(text: "6")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(7)
                }) {
                    KeysRowButtonText(text: "7")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(8)
                }) {
                    KeysRowButtonText(text: "8")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {
                    self.updateForDigit(9)
                }) {
                    KeysRowButtonText(text: "9")
                }
                    .cornerRadius(buttonCornerRadius)
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
    }

    private func updateForDigit(_ digit: Int) {
        userAction.action = .digit(digit)
        guard let selectedCoordinate = selectedCoordinate, !startingGrid.containsAValue(at: selectedCoordinate) else {
            return
        }

        let coordinateValue = CoordinateValue(r: selectedCoordinate.r, c: selectedCoordinate.c, s: selectedCoordinate.s, v: digit)
        if isEditing {
            editGrid.addGuess(value: digit, at: (r: selectedCoordinate.r, c: selectedCoordinate.c, s: selectedCoordinate.s))
        } else {
            editGrid.removeValues(at: selectedCoordinate)
            workingGrid.add(coordinateValue)
            gridIsComplete = workingGrid.isSolved
        }
    }
}

struct KeysRow_Previews: PreviewProvider {
    static var previews: some View {
        KeysRow(gridIsComplete: .constant(false), selectedCoordinate: nil, isEditing: false)
            .environmentObject(UserAction())
            .environmentObject(GridValues(grid: GridFactory.easyGrid, startingGrid: GridFactory.easyGrid))
            .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
            .environmentObject(EditGridValues(grid: []))
    }
}
