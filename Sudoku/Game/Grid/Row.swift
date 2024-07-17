//
//  Row.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Row: View {

    var selectedCell: SelectedCell
    var userAction: UserAction
    let workingGrid: GridValues

    let viewModel: RowViewModel

    var body: some View {
        GridRow {
            ForEach(viewModel.columns, id: \.self) { columnIndex in
                Button(action: {
                    self.updateSelectedButton(columnIndex: columnIndex)
                }) {
                    self.renderCellText(columnIndex: columnIndex)
                }
                .buttonBorderShape(.roundedRectangle(radius: 0)) // keeps UI consistent on visionOS
                .border(Color.black, width: 1)
                .background(self.viewModel.backgroundColorFor(columnIndex, selectedCell: self.selectedCell.coordinate))
            }
        }
    }

    private func isSelected(columnIndex: Int) -> Bool {
        return selectedCell.coordinate?.r == viewModel.index &&
            selectedCell.coordinate?.c == columnIndex &&
            selectedCell.coordinate?.s == viewModel.squareIndex
    }

    private func setRowButtonText(columnIndex: Int) -> String {
        let coordinate = Coordinate(r: viewModel.index, c: columnIndex, s: viewModel.squareIndex)
        if let value = workingGrid.getValue(at: coordinate, grid: workingGrid.grid) {
            return "\(value)"
        } else {
            return ""
        }
    }

    private func updateSelectedButton(columnIndex: Int) {
        if !isSelected(columnIndex: columnIndex) {
            selectedCell.coordinate = Coordinate(r: viewModel.index, c: viewModel.columns[columnIndex], s: viewModel.squareIndex)
        } else {
            selectedCell.coordinate = nil
        }
        userAction.action = .none
    }

    // Note: Use AnyView to type erase View.
    private func renderCellText(columnIndex: Int) -> AnyView {
        let coordinate = Coordinate(r: viewModel.index, c: columnIndex, s: viewModel.squareIndex)
        let guesses = viewModel.guessesFor(columnIndex)

        if !workingGrid.containsAValue(at: coordinate, grid: workingGrid.grid) && !guesses.isEmpty {
            return AnyView(EditCellGrid(values: guesses))
        } else {
            let text = setRowButtonText(columnIndex: columnIndex)
            if let coordinateValue = workingGrid.getCoordinateValue(at: coordinate, grid: workingGrid.grid) {
                let foregroundColor = workingGrid.foregroundColorFor(coordinateValue) ?? .black
                return AnyView(RowButtonText(text: text, foregroundColor: foregroundColor))
            } else {
                return AnyView(RowButtonText(text: text, foregroundColor: .black))
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        Row(selectedCell: SelectedCell(),
            userAction: UserAction(),
            workingGrid: GridValues(startingGrid: GridFactory.easyGrid),
            viewModel: RowViewModel(index: 2,
                                    squareIndex: 0,
                                    guesses: []))
        .environment(WindowSize(size: geometry.size))
    }
}
