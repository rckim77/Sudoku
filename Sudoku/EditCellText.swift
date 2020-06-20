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

    private var minHeight: CGFloat {
        if isIpad {
            return 65.5
        } else {
            return 45.5
        }
    }

    var body: some View {
        VStack(spacing: -2) {
            HStack(spacing: 0) {
                Text(text(for: 0))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 1))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 2))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            HStack(spacing: 0) {
                Text(text(for: 3))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 4))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 5))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            HStack(spacing: 0) {
                Text(text(for: 6))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 7))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 8))
                    .foregroundColor(Color("dynamicBlue"))
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, minHeight: minHeight)
    }

    private func text(for editIndex: Int) -> String {
        if values.contains(where: { $0 == editIndex + 1 }) {
            return "\(editIndex + 1)"
        } else {
            return ""
        }
    }
}

struct EditCellText_Previews: PreviewProvider {
    static var previews: some View {
        EditCellText(values: Set(arrayLiteral: 1, 2, 3, 4, 7, 8, 9))
    }
}
