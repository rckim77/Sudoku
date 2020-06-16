//
//  EditCellText.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct EditCellText: View {
    let values: Set<Int>

    var body: some View {
        VStack(spacing: -4) {
            HStack(spacing: 2) {
                Text(text(for: 0))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                Text(text(for: 1))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                Text(text(for: 2))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
            }
            HStack(spacing: 2) {
                Text(text(for: 3))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                Text(text(for: 4))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                Text(text(for: 5))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
            }
            HStack(spacing: 2) {
                Text(text(for: 6))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                Text(text(for: 7))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                Text(text(for: 8))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
            }
        }.frame(maxWidth: .infinity, minHeight: 45.5)
    }

    private func text(for editIndex: Int) -> String {
        if values.contains(where: { $0 == editIndex }) {
            print("\(editIndex)")
            return "\(editIndex)"
        } else {
            print("blank")
            return ""
        }
    }
}
