//
//  Row.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Row: View {

    @EnvironmentObject
    private var selectedCell: SelectedCell
    @EnvironmentObject
    private var userAction: UserAction
    @EnvironmentObject
    private var startingGrid: StartingGridValues
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editState: EditState
    @EnvironmentObject
    private var editGrid: EditGridValues

    let index: Int
    let columns: [Int]
    let squareIndex: Int

    private let backgroundColor = Color("dynamicGridWhite")
    private let selectedBackgroundColor = Color("dynamicGridSelection")

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                self.updateSelectedButton(columnIndex: 0)
            }) {
                renderCellText(columnIndex: 0)
            }
                .border(Color.black, width: 1)
                .background(isSelected(columnIndex: 0) ? selectedBackgroundColor : backgroundColor)
            Button(action: {
                self.updateSelectedButton(columnIndex: 1)
            }) {
                renderCellText(columnIndex: 1)
            }
                .border(Color.black, width: 1)
                .background(isSelected(columnIndex: 1) ? selectedBackgroundColor : backgroundColor)
            Button(action: {
                self.updateSelectedButton(columnIndex: 2)
            }) {
                renderCellText(columnIndex: 2)
            }
                .border(Color.black, width: 1)
                .background(isSelected(columnIndex: 2) ? selectedBackgroundColor : backgroundColor)
        }
        .frame(maxWidth: .infinity)
    }

    private func isSelected(columnIndex: Int) -> Bool {
        return selectedCell.coordinate?.r == index &&
            selectedCell.coordinate?.c == columnIndex &&
            selectedCell.coordinate?.s == squareIndex
    }

    private func setRowButtonText(columnIndex: Int) -> String {
        let coordinate = (r: index, c: columnIndex, s: squareIndex)
        if let buttonText = workingGrid.retrieveValue(at: coordinate) {
            return "\(buttonText)"
        } else {
            return ""
        }
    }

    private func setForegroundColor(columnIndex: Int) -> Color {
        let currentCoordinate = (r: index, c: columnIndex, s: squareIndex)
        let workingGridHasAValue = workingGrid.containsAValue(at: currentCoordinate)
        let startingGridHasAValue = startingGrid.containsAValue(at: currentCoordinate)
        if workingGridHasAValue && !startingGridHasAValue {
            if case let UserAction.ActionType.digit(digit) = userAction.action,
                coordinate(currentCoordinate, withValue: digit, isInvalidFor: startingGrid) &&
                isSelected(columnIndex: columnIndex) {
                // user has just entered an invalid digit
                return .red
            }

            if let retrievedValue = workingGrid.retrieveValue(at: currentCoordinate),
                coordinate(currentCoordinate, withValue: retrievedValue, isInvalidFor: startingGrid) {
                // persist red text for other invalid digits in square that haven't been cleared
                return .red
            }

            // in working grid but not starting grid
            return Color("dynamicBlue")
        } else {
            // starting grid
            return .black
        }
    }

    /// Encapsulates logic to check whether there are duplicates of the input value in the current
    /// coordinate's 3x3 square, grid row, or grid column.
    private func coordinate(_ coordinate: Coordinate, withValue value: Int, isInvalidFor startingGrid: StartingGridValues) -> Bool {
        return startingGrid.square(coordinate.s, contains: value) ||
            startingGrid.fullRow(for: coordinate, contains: value) ||
            startingGrid.fullColumn(for: coordinate, contains: value)
    }

    private func updateSelectedButton(columnIndex: Int) {
        if !isSelected(columnIndex: columnIndex) {
            selectedCell.coordinate = (r: index, c: columns[columnIndex], s: squareIndex)
        } else {
            selectedCell.coordinate = nil
        }
        userAction.action = .none
    }

    // Note: Use AnyView to type erase View.
    private func renderCellText(columnIndex: Int) -> AnyView {
        let currentCoordinate = (r: index, c: columnIndex, s: squareIndex)
        if !workingGrid.containsAValue(at: currentCoordinate) {
            let values = editGrid.guesses(for: currentCoordinate)?.values ?? Set<Int>()
            return AnyView(EditCellText(values: values))
        } else {
            return AnyView(RowButtonText(text: setRowButtonText(columnIndex: columnIndex), foregroundColor: setForegroundColor(columnIndex: columnIndex)))
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(index: 0, columns: [0, 1, 2], squareIndex: 0)
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
            .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
            .environmentObject(GridValues(grid: GridFactory.easyGrid))
            .environmentObject(EditState())
            .environmentObject(EditGridValues(grid: []))
    }
}
