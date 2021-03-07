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
    private var editGrid: EditGridValues
    @Binding
    var alert: AlertItem?
    
    let selectedCoordinate: Coordinate?
    let isEditing: Bool

    private let buttonCornerRadius: CGFloat = 5
    private var horizontalSpacing: CGFloat {
        isIpad ? 80 : 8
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
                        KeysRowButtonText(text: "\(digit)")
                    }
                    .cornerRadius(self.buttonCornerRadius)
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
                .frame(width: horizontalSpacing)
        }
    }

    private func updateForDigit(_ digit: Int) {
        userAction.action = .digit(digit)
        guard let selectedCoordinate = selectedCoordinate, !workingGrid.containsAValue(at: selectedCoordinate, grid: workingGrid.startingGrid) else {
            return
        }

        let coordinateValue = CoordinateValue(r: selectedCoordinate.r, c: selectedCoordinate.c, s: selectedCoordinate.s, v: digit)
        if isEditing {
            editGrid.updateGuesses(value: digit, at: (r: selectedCoordinate.r, c: selectedCoordinate.c, s: selectedCoordinate.s))
        } else {
            editGrid.removeValues(at: selectedCoordinate)
            workingGrid.add(coordinateValue)
            if workingGrid.isSolved {
                alert = AlertItem(id: .finishedGame)
            } else {
                alert = nil
            }
        }
    }
}

struct KeysRow_Previews: PreviewProvider {
    static var previews: some View {
        KeysRow(alert: .constant(AlertItem(id: .finishedGame)), selectedCoordinate: nil, isEditing: false)
            .environmentObject(UserAction())
            .environmentObject(GridValues(startingGrid: GridFactory.easyGrid))
            .environmentObject(EditGridValues(grid: []))
    }
}
