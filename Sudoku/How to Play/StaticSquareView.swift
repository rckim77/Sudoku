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
    
    private var borderWidth: CGFloat {
        screenHeight > 667 ? 3 : 2
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<3) { index in
                if index == 0 && highlightSection == .row {
                    StaticRowView(rowIndex: index, highlightSection: highlightSection)
                        .background(.yellow)
                } else {
                    StaticRowView(rowIndex: index, highlightSection: highlightSection)
                }
            }
        }
        .border(.black, width: borderWidth)
    }
}

#Preview {
    VStack {
        StaticSquareView(index: 0, highlightSection: .square)
        StaticSquareView(index: 1, highlightSection: .row)
        StaticSquareView(index: 2, highlightSection: .column)
    }
    .padding(.horizontal, 132)
}
