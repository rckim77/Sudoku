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
    @Binding
    var alert: AlertItem?
    @Binding
    var alertIsPresented: Bool
    
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
        userAction.action = .digit(digit)
        guard let selectedCoordinate = selectedCoordinate, !workingGrid.containsAValue(at: selectedCoordinate, grid: workingGrid.startingGrid) else {
            return
        }

        let coordinateValue = CoordinateValue(r: selectedCoordinate.r, c: selectedCoordinate.c, s: selectedCoordinate.s, v: digit)
        if isEditing {
            editGrid.updateGuesses(value: digit, at: Coordinate(r: selectedCoordinate.r, c: selectedCoordinate.c, s: selectedCoordinate.s))
        } else {
            editGrid.removeValues(at: selectedCoordinate)
            workingGrid.add(coordinateValue)
            
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

#Preview {
    KeysRow(editGrid: EditGridValues(grid: []),
            userAction: UserAction(),
            workingGrid: GridValues(startingGrid: GridFactory.easyGrid),
            alert: .constant(.completedCorrectly),
            alertIsPresented: .constant(false),
            selectedCoordinate: nil,
            isEditing: false)
}
