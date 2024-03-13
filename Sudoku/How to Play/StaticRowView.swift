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
                    RowButtonText(text: "\(colIndex)", foregroundColor: .black)
                        .padding(.horizontal, 6)
                        .frame(maxWidth: .infinity)
                        .background(.yellow)
                        .border(.black, width: 1)
                } else {
                    RowButtonText(text: "\(rowIndex)", foregroundColor: .black)
                        .padding(.horizontal, 6)
                        .frame(maxWidth: .infinity)
                        .border(.black, width: 1)
                }
            }
        }
    }
}

#Preview {
    StaticRowView(rowIndex: 0, highlightSection: .column)
}
