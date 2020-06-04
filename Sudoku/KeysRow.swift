//
//  KeysRow.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct KeysRow: View {

    private let buttonCornerRadius: CGFloat = 5

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            HStack(spacing: 2) {
                Button(action: {}) {
                    KeysRowButtonText(text: "1")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "2")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "3")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "4")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "5")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "6")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "7")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "8")
                }
                    .cornerRadius(buttonCornerRadius)
                Button(action: {}) {
                    KeysRowButtonText(text: "9")
                }
                    .cornerRadius(buttonCornerRadius)
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
    }
}

struct KeysRow_Previews: PreviewProvider {
    static var previews: some View {
        KeysRow()
    }
}
