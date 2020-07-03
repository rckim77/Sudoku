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

    let viewModel: RowViewModel

    var body: some View {
        HStack(spacing: 0) {
            ForEach(viewModel.columns, id: \.self) { columnIndex in
                Button(action: {
                    self.updateSelectedButton(columnIndex: columnIndex)
                }) {
                    self.renderCellText(columnIndex: columnIndex)
                }
                    .border(Color.black, width: 1)
                .background(self.viewModel.backgroundColorFor(columnIndex, selectedCell: self.selectedCell.coordinate))
            }
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
        if let value = viewModel.workingGridRetrieveValue(at: coordinate) {
            return "\(value)"
        } else {
            return ""
        }
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
        if viewModel.hasGuessesAndNoValue(at: columnIndex) {
            let guess = viewModel.guessFor(columnIndex)
            return AnyView(EditCellGrid(values: guess))
        } else {
            let text = setRowButtonText(columnIndex: columnIndex)
            let foregroundColor = viewModel.foregroundColorFor(columnIndex) ?? .black
            return AnyView(RowButtonText(text: text, foregroundColor: foregroundColor))
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(viewModel: RowViewModel(index: 0,
                                    squareIndex: 0,
                                    startingGrid: GridFactory.easyGrid,
                                    workingGrid: GridFactory.easyGrid,
                                    colorGrid: [],
                                    guesses: []))
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
    }
}
