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
    @EnvironmentObject
    private var selectedCell: SelectedCell
    @EnvironmentObject
    private var workingGrid: GridValues
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
        self.userAction.action = .digit(digit)
        if let selectedCoordinate = self.selectedCell.coordinate {
            let coordinateValue = (r: selectedCoordinate.r, c: selectedCoordinate.c, s: selectedCoordinate.s, v: digit)
            self.workingGrid.add(coordinateValue)
        }
    }
}

struct KeysRow_Previews: PreviewProvider {
    static var previews: some View {
        KeysRow()
    }
}
