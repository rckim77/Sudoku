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
    
    private let squareRowRanges = [(0...2), (3...5), (6...8)]
    private var borderWidth: CGFloat {
        screenHeight > 667 ? 3 : 2
    }
    
    private var row: some View {
        GridRow {
            ForEach([0, 1, 2], id: \.self) { colIndex in
                if colIndex == 0 && highlightSection == .column {
                    Text("\(colIndex)")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .border(.black, width: 1)
                        .background(.yellow)
                } else {
                    Text("\(colIndex)")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .border(.black, width: 1)
                }
            }
        }
    }
    
    private var square: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach([0, 1, 2], id: \.self) { index in
                if index == 0 && highlightSection == .row {
                    row
                        .background(.yellow)
                } else {
                    row
                }
            }
        }
        .border(.black, width: borderWidth)
    }
    

    var body: some View {
        HStack {
            Spacer()
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(squareRowRanges, id: \.self) { squareRowRange in
                    GridRow {
                        ForEach(squareRowRange, id: \.self) { squareIndex in
                            if squareIndex == 0 && highlightSection == .square {
                                square
                                    .background(.yellow)
                            } else {
                                square
                            }
                        }
                    }
                }
            }
            .padding(borderWidth)
            .border(.black, width: borderWidth)
            Spacer()
        }
    }
}

#Preview {
    VStack {
        StaticGridView(highlightSection: .square)
        StaticGridView(highlightSection: .column)
        StaticGridView(highlightSection: .row)
    }
}
