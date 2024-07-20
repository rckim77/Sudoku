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
    
    private let borderWidth: CGFloat = 2
    
    private var isValidSquare: Bool {
        return index == 0 || index == 1 || index == 2
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<3) { rowIndex in
                StaticRowView(rowIndex: rowIndex, squareIndex: index, highlightSection: highlightSection, grid: grid)
                    .background(getBackgroundColor(rowIndex: rowIndex, isValidSquare: isValidSquare, highlightSection: highlightSection))
            }
        }
        .border(.black, width: borderWidth)
    }
    
    private func getBackgroundColor(rowIndex: Int, isValidSquare: Bool, highlightSection: HighlightSection) -> Color {
        if rowIndex == 0 && isValidSquare && highlightSection == .row {
            return .yellow
        } else {
            return .clear
        }
    }
}

#Preview {
    GeometryReader { geometry in
        VStack {
            StaticSquareView(index: 0, highlightSection: .square, grid: GridFactory.easyGrid)
                .environment(WindowSize(size: geometry.size))
            StaticSquareView(index: 1, highlightSection: .row, grid: GridFactory.easyGrid)
                .environment(WindowSize(size: geometry.size))
            StaticSquareView(index: 2, highlightSection: .column, grid: GridFactory.easyGrid)
                .environment(WindowSize(size: geometry.size))
        }
        .padding(.horizontal, 132)
    }
}
