//
//  GridContainerView.swift
//  Sudoku
//
//  Created by Ray Kim on 7/20/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct GridContainerView<Content: View>: View {
    
    let content: (Int) -> Content
    
    private let borderWidth: CGFloat = 2
    private let squareRowRanges = [(0...2), (3...5), (6...8)]
    
    init(@ViewBuilder content: @escaping (Int) -> Content) {
        self.content = content
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(squareRowRanges, id: \.self) { squareRowRange in
                GridRow {
                    ForEach(squareRowRange, id: \.self) { squareIndex in
                        content(squareIndex)
                    }
                }
            }
        }
        .padding(borderWidth)
        .border(.black, width: borderWidth)
    }
}
