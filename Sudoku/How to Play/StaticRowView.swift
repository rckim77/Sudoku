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
    let highlightSection: HighlightSection
    
    var body: some View {
        GridRow {
            ForEach(0..<3) { colIndex in
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
}

#Preview {
    StaticRowView(rowIndex: 0, highlightSection: .column)
}
