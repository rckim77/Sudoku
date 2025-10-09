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

    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                EditCellGridText(digitText: text(for: 0))
                    .opacity(getOpacity(for: 0))
                EditCellGridText(digitText: text(for: 1))
                    .opacity(getOpacity(for: 1))
                EditCellGridText(digitText: text(for: 2))
                    .opacity(getOpacity(for: 2))
            }
            GridRow {
                EditCellGridText(digitText: text(for: 3))
                    .opacity(getOpacity(for: 3))
                EditCellGridText(digitText: text(for: 4))
                    .opacity(getOpacity(for: 4))
                EditCellGridText(digitText: text(for: 5))
                    .opacity(getOpacity(for: 5))
            }
            GridRow {
                EditCellGridText(digitText: text(for: 6))
                    .opacity(getOpacity(for: 6))
                EditCellGridText(digitText: text(for: 7))
                    .opacity(getOpacity(for: 7))
                EditCellGridText(digitText: text(for: 8))
                    .opacity(getOpacity(for: 8))
            }
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
    }

    private func text(for editIndex: Int) -> String {
        if values.contains(where: { $0 == editIndex + 1 }) {
            return "\(editIndex + 1)"
        } else { // this should never show but is needed for consistent vertical spacing
            return "X"
        }
    }
    
    /// This function hides placeholder edit values or shows appropriate edit values
    private func getOpacity(for editIndex: Int) -> Double {
        if values.contains(where: { $0 == editIndex + 1 }) {
            return 1
        } else {
            return 0
        }
    }
}

#Preview {
    GeometryReader { geometry in
        EditCellGrid(values: Set(arrayLiteral: 1, 2, 3, 4, 7, 8, 9))
            .environment(WindowSize(size: geometry.size))
    }
}
