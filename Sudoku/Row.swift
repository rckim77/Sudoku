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
    var selectedCell: SelectedCell

    private func isSelected(columnIndex: Int) -> Bool {
        return selectedCell.coordinate?.row == index &&
            selectedCell.coordinate?.column == columnIndex &&
            selectedCell.coordinate?.square == squareIndex
    }
    let index: Int
    let columns: [Int]
    let squareIndex: Int

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                if !self.isSelected(columnIndex: 0) {
                    self.selectedCell.coordinate = (row: self.index, column: self.columns[0], square: self.squareIndex)
                } else {
                    self.selectedCell.coordinate = nil
                }
            }) {
                Text("1")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(isSelected(columnIndex: 0) ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                if !self.isSelected(columnIndex: 1) {
                    self.selectedCell.coordinate = (row: self.index, column: self.columns[1], square: self.squareIndex)
                } else {
                    self.selectedCell.coordinate = nil
                }
            }) {
                Text("2")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(isSelected(columnIndex: 1) ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                if !self.isSelected(columnIndex: 2) {
                    self.selectedCell.coordinate = (row: self.index, column: self.columns[2], square: self.squareIndex)
                } else {
                    self.selectedCell.coordinate = nil
                }
            }) {
                Text("3")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .background(isSelected(columnIndex: 2) ? Color.gray.opacity(0.4) : Color.white)
        }
        .frame(maxWidth: .infinity)
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(index: 0, columns: [0, 1, 2], squareIndex: 0)
    }
}
