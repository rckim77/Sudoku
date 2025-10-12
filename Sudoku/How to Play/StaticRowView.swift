//
//  StaticRowView.swift
//  Sudoku
//
//  Created by Ray Kim on 3/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct StaticRowView: View {
    
    let rowIndex: Int
    let squareIndex: Int
    let highlightSection: HighlightSection
    let grid: [CoordinateValue]

    private var isValidSquare: Bool {
        return squareIndex == 0 || squareIndex == 3 || squareIndex == 6
    }
    
    var body: some View {
        GridRow {
            ForEach(0..<3) { colIndex in
                let digit = grid.first(where: { $0.r == rowIndex && $0.c == colIndex && $0.s == squareIndex })?.v ?? -1
                let digitText = digit == -1 ? " " : "\(digit)"
                RowButtonText(text: digitText, foregroundColor: .black, isStatic: true)
                    .background(getBackgroundColor(colIndex: colIndex, isValidSquare: isValidSquare, highlightSection: highlightSection))
                    .border(.black, width: 1)
            }
        }
    }
    
    private func getBackgroundColor(colIndex: Int, isValidSquare: Bool, highlightSection: HighlightSection) -> Color {
        if colIndex == 0 && isValidSquare && highlightSection == .column {
            return .yellow
        } else {
            return .clear
        }
    }
}

#Preview {
    GeometryReader { geometry in
        StaticRowView(rowIndex: 0, squareIndex: 0, highlightSection: .column, grid: GridFactory.easyGrid)
            .environment(WindowSize(size: geometry.size))
    }
}
