//
//  StaticSquareView.swift
//  Sudoku
//
//  Created by Ray Kim on 3/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct StaticSquareView: View {
    
    let index: Int
    let highlightSection: HighlightSection
    let grid: [CoordinateValue]
    
    private var borderWidth: CGFloat {
        screenHeight > 667 ? 3 : 2
    }
    
    private var isValidSquare: Bool {
        return index == 0 || index == 1 || index == 2
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<3) { rowIndex in
                if rowIndex == 0 && isValidSquare && highlightSection == .row {
                    StaticRowView(rowIndex: rowIndex, squareIndex: index, highlightSection: highlightSection, grid: grid)
                        .background(.yellow)
                } else {
                    StaticRowView(rowIndex: rowIndex, squareIndex: index, highlightSection: highlightSection, grid: grid)
                }
            }
        }
        .border(.black, width: borderWidth)
    }
}

#Preview {
    VStack {
        StaticSquareView(index: 0, highlightSection: .square, grid: GridFactory.easyGrid)
        StaticSquareView(index: 1, highlightSection: .row, grid: GridFactory.easyGrid)
        StaticSquareView(index: 2, highlightSection: .column, grid: GridFactory.easyGrid)
    }
    .padding(.horizontal, 132)
}
