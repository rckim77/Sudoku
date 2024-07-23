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
    
    static var spacerWidth: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 4
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return 140
        } else {
            return 400
        }
    }
    
    let highlightSection: HighlightSection
    let grid: [CoordinateValue]
    
    private let squareRowRanges = [(0...2), (3...5), (6...8)]
    private let borderWidth: CGFloat = 2

    var body: some View {
        GridContainerView { squareIndex in
            StaticSquareView(index: squareIndex, highlightSection: highlightSection, grid: grid)
                .background(getBackgroundColor(squareIndex: squareIndex, highlightSection: highlightSection))
        }
    }
    
    private func getBackgroundColor(squareIndex: Int, highlightSection: HighlightSection) -> Color {
        if squareIndex == 0 && highlightSection == .square {
            return .yellow
        } else {
            return Color("dynamicGridWhite")
        }
    }
}

#Preview {
    GeometryReader { geometry in
        StaticGridView(highlightSection: .column, grid: GridFactory.easyGrid)
            .environment(WindowSize(size: geometry.size))
    }
}
