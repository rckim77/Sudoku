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

    let index: Int
    let columns: [Int]
    let squareIndex: Int

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                self.updateSelectedButton(columnIndex: 0)
            }) {
                RowButtonText(text: shouldClearText(columnIndex: 0) ? "" : "1")
            }
                .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(isSelected(columnIndex: 0) ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                self.updateSelectedButton(columnIndex: 1)
            }) {
                RowButtonText(text: shouldClearText(columnIndex: 1) ? "" : "2")
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(isSelected(columnIndex: 1) ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                self.updateSelectedButton(columnIndex: 2)
            }) {
                RowButtonText(text: shouldClearText(columnIndex: 2) ? "" :  "3")
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .background(isSelected(columnIndex: 2) ? Color.gray.opacity(0.4) : Color.white)
        }
        .frame(maxWidth: .infinity)
    }

    private func isSelected(columnIndex: Int) -> Bool {
        return selectedCell.coordinate?.row == index &&
            selectedCell.coordinate?.column == columnIndex &&
            selectedCell.coordinate?.square == squareIndex
    }

    private func shouldClearText(columnIndex: Int) -> Bool {
        return isSelected(columnIndex: columnIndex) && userAction.action == .clear
    }

    private func updateSelectedButton(columnIndex: Int) {
        if !isSelected(columnIndex: columnIndex) {
            selectedCell.coordinate = (row: index, column: columns[columnIndex], square: squareIndex)
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
