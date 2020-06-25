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
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editState: EditState

    let viewModel: RowViewModel

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                self.updateSelectedButton(columnIndex: 0)
            }) {
                renderCellText(columnIndex: 0)
            }
                .border(Color.black, width: 1)
                .background(viewModel.backgroundColorFor(0))
            Button(action: {
                self.updateSelectedButton(columnIndex: 1)
            }) {
                renderCellText(columnIndex: 1)
            }
                .border(Color.black, width: 1)
                .background(viewModel.backgroundColorFor(1))
            Button(action: {
                self.updateSelectedButton(columnIndex: 2)
            }) {
                renderCellText(columnIndex: 2)
            }
                .border(Color.black, width: 1)
                .background(viewModel.backgroundColorFor(2))
        }
        .frame(maxWidth: .infinity)
    }

    private func isSelected(columnIndex: Int) -> Bool {
        return selectedCell.coordinate?.r == viewModel.index &&
            selectedCell.coordinate?.c == columnIndex &&
            selectedCell.coordinate?.s == viewModel.squareIndex
    }

    private func setRowButtonText(columnIndex: Int) -> String {
        let coordinate = (r: viewModel.index, c: columnIndex, s: viewModel.squareIndex)
        if let buttonText = workingGrid.retrieveValue(at: coordinate) {
            return "\(buttonText)"
        } else {
            return ""
        }
    }

    private func setForegroundColor(columnIndex: Int) -> Color {
        let currentCoordinate = (r: viewModel.index, c: columnIndex, s: viewModel.squareIndex)
        let workingGridHasAValue = workingGrid.containsAValue(at: currentCoordinate)
        let startingGridHasAValue = viewModel.startingGridContainsAValue(at: currentCoordinate)
        if workingGridHasAValue && !startingGridHasAValue {
            if case let UserAction.ActionType.digit(digit) = userAction.action,
                coordinate(currentCoordinate, withValue: digit, isInvalidFor: viewModel.startingGrid) &&
                isSelected(columnIndex: columnIndex) {
                // user has just entered an invalid digit
                return .red
            }

            if let retrievedValue = workingGrid.retrieveValue(at: currentCoordinate),
                coordinate(currentCoordinate, withValue: retrievedValue, isInvalidFor: viewModel.startingGrid) {
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
    private func coordinate(_ coordinate: Coordinate, withValue value: Int, isInvalidFor startingGrid: [CoordinateValue]) -> Bool {
        return viewModel.square(coordinate.s, contains: value) ||
            viewModel.fullRow(for: coordinate, contains: value) ||
            viewModel.fullColumn(for: coordinate, contains: value)
    }

    private func updateSelectedButton(columnIndex: Int) {
        if !isSelected(columnIndex: columnIndex) {
            selectedCell.coordinate = (r: viewModel.index, c: viewModel.columns[columnIndex], s: viewModel.squareIndex)
        } else {
            selectedCell.coordinate = nil
        }
        userAction.action = .none
    }

    // Note: Use AnyView to type erase View.
    private func renderCellText(columnIndex: Int) -> AnyView {
        let currentCoordinate = (r: viewModel.index, c: columnIndex, s: viewModel.squareIndex)
        if !workingGrid.containsAValue(at: currentCoordinate) {
            let guess = viewModel.guessFor(columnIndex)
            return AnyView(EditCellText(values: guess))
        } else {
            return AnyView(RowButtonText(text: setRowButtonText(columnIndex: columnIndex), foregroundColor: setForegroundColor(columnIndex: columnIndex)))
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(viewModel: RowViewModel(index: 0,
                                    columns: [0, 1, 2],
                                    squareIndex: 0,
                                    selectedColumnIndex: nil,
                                    startingGrid: GridFactory.easyGrid,
                                    guesses: []))
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
            .environmentObject(StartingGridValues(grid: GridFactory.easyGrid))
            .environmentObject(GridValues(grid: GridFactory.easyGrid))
            .environmentObject(EditState())
    }
}
