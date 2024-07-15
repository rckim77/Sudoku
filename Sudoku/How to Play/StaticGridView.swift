//
//  StaticGridView.swift
//  Sudoku
//
//  Created by Ray Kim on 3/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

enum HighlightSection {
    case row, column, square
}

struct StaticGridView: View {
    
    let highlightSection: HighlightSection
    let grid: [CoordinateValue]
    
    private let squareRowRanges = [(0...2), (3...5), (6...8)]
    private let borderWidth: CGFloat = 2

    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(squareRowRanges, id: \.self) { squareRowRange in
                GridRow {
                    ForEach(squareRowRange, id: \.self) { squareIndex in
                        if squareIndex == 0 && highlightSection == .square {
                            StaticSquareView(index: squareIndex, highlightSection: highlightSection, grid: grid)
                                .background(.yellow)
                        } else {
                            StaticSquareView(index: squareIndex, highlightSection: highlightSection, grid: grid)
                                .background(Color("dynamicGridWhite"))
                        }
                    }
                }
            }
        }
        .padding(borderWidth)
        .border(.black, width: borderWidth)
    }
}

#Preview {
    VStack {
        StaticGridView(highlightSection: .column, grid: GridFactory.easyGrid)
        StaticGridView(highlightSection: .row, grid: GridFactory.easyGrid)
        StaticGridView(highlightSection: .square, grid: GridFactory.easyGrid)
    }
}
