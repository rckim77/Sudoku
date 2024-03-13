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
                if colIndex == 0 && isValidSquare && highlightSection == .column {
                    RowButtonText(text: digitText, foregroundColor: .black)
                        .padding(.horizontal, 6)
                        .frame(maxWidth: .infinity)
                        .background(.yellow)
                        .border(.black, width: 1)
                } else {
                    RowButtonText(text: digitText, foregroundColor: .black)
                        .padding(.horizontal, 6)
                        .frame(maxWidth: .infinity)
                        .border(.black, width: 1)
                }
            }
        }
    }
}

#Preview {
    StaticRowView(rowIndex: 0, squareIndex: 0, highlightSection: .column, grid: GridFactory.easyGrid)
}
