//
//  EditCellGrid.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct EditCellGrid: View {
    
    @Environment(WindowSize.self) private var windowSize

    let values: Set<Int>

    private var minHeight: CGFloat {
        (windowSize.size.width - (2 * SudokuGrid.spacerWidth)) / 9
    }

    private var verticalSpacing: CGFloat {
        isIpad ? 2 : -4
    }

    var body: some View {
        VStack(spacing: verticalSpacing) {
            HStack(spacing: 0) {
                EditCellGridText(digitText: text(for: 0))
                EditCellGridText(digitText: text(for: 1))
                EditCellGridText(digitText: text(for: 2))
            }
            HStack(spacing: 0) {
                EditCellGridText(digitText: text(for: 3))
                EditCellGridText(digitText: text(for: 4))
                EditCellGridText(digitText: text(for: 5))
            }
            HStack(spacing: 0) {
                EditCellGridText(digitText: text(for: 6))
                EditCellGridText(digitText: text(for: 7))
                EditCellGridText(digitText: text(for: 8))
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

#Preview {
    GeometryReader { geometry in
        EditCellGrid(values: Set(arrayLiteral: 1, 2, 3, 4, 7, 8, 9))
            .environment(WindowSize(size: geometry.size))
    }
}
