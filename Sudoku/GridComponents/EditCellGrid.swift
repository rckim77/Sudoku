//
//  EditCellGrid.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct EditCellGrid: View {
    let values: Set<Int>
    
    private let foregroundColor = Color("dynamicBlue")

    private var minHeight: CGFloat {
        if isIpad {
            return 65.5
        } else {
            return 43.5
        }
    }

    var body: some View {
        VStack(spacing: -3) {
            HStack(spacing: 0) {
                Text(text(for: 0))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 1))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 2))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            HStack(spacing: 0) {
                Text(text(for: 3))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 4))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 5))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            HStack(spacing: 0) {
                Text(text(for: 6))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 7))
                    .foregroundColor(foregroundColor)
                    .font(.system(.footnote, design: .rounded))
                    .frame(maxWidth: .infinity)
                Text(text(for: 8))
                    .foregroundColor(foregroundColor)
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

struct EditCellGrid_Previews: PreviewProvider {
    static var previews: some View {
        EditCellGrid(values: Set(arrayLiteral: 1, 2, 3, 4, 7, 8, 9))
    }
}
