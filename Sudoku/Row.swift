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

    let index: Int
    let columns: [Int]
    let squareIndex: Int

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                self.updateSelectedButton(columnIndex: 0)
            }) {
                RowButtonText(text: setRowButtonText(columnIndex: 0), foregroundColor: setForegroundColor(columnIndex: 0))
            }
                .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(isSelected(columnIndex: 0) ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                self.updateSelectedButton(columnIndex: 1)
            }) {
                RowButtonText(text: setRowButtonText(columnIndex: 1), foregroundColor: setForegroundColor(columnIndex: 1))
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(isSelected(columnIndex: 1) ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                self.updateSelectedButton(columnIndex: 2)
            }) {
                RowButtonText(text: setRowButtonText(columnIndex: 2), foregroundColor: setForegroundColor(columnIndex: 2))
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .background(isSelected(columnIndex: 2) ? Color.gray.opacity(0.4) : Color.white)
        }
        .frame(maxWidth: .infinity)
    }

    private func isSelected(columnIndex: Int) -> Bool {
        return selectedCell.coordinate?.r == index &&
            selectedCell.coordinate?.c == columnIndex &&
            selectedCell.coordinate?.s == squareIndex
    }

    private func setRowButtonText(columnIndex: Int) -> String {
        if let buttonText = getRowButtonValue(columnIndex: columnIndex) {
            return "\(buttonText)"
        } else {
            return ""
        }
    }

    private func getRowButtonValue(columnIndex: Int) -> Int? {
        let rowValues = workingGrid.values(in: squareIndex).filter { coordinateValue -> Bool in
            coordinateValue.r == index
        }
        guard !rowValues.isEmpty else {
            return nil
        }

        if let value = rowValues.filter({ coordinateValue -> Bool in
            coordinateValue.c == columnIndex
        }).first?.v {
            return value
        } else {
            return nil
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
            return .blue
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
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(index: 0, columns: [0, 1, 2], squareIndex: 0)
    }
}
