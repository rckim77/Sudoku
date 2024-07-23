//
//  HowToPlayView.swift
//  Sudoku
//
//  Created by Ray Kim on 3/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct HowToPlayView: View {
    
    /// Note: For iPad and iPhone, the return value must match `StaticGridView.spacerWidth`.
    private var horizontalContainerPadding: CGFloat {
        if isVision {
            return 300
        } else if isIpad {
            return 140
        } else {
            return 4
        }
    }

    private var horizontalTextPadding: CGFloat {
        isIphone ? 12 : 0
    }
    
    /// Used for additional grid padding on visionOS.
    private var horizontalGridPadding: CGFloat {
        isVision ? StaticGridView.spacerWidth - horizontalContainerPadding : 0
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Sudoku is a puzzle where you fill all the individual digit squares inside a grid with the right digit. But what determines the right digit? There are a few requirements that must be met:")
                        Text("First, every row in the grid must include the numbers 1 to 9. Each digit can only appear once.")
                    }
                    .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .row, grid: GridFactory.easyGrid)
                        .padding(.horizontal, horizontalGridPadding)
                    Text("Second, every column in the grid must also include the numbers 1 to 9 exactly once.")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .column, grid: GridFactory.easyGrid)
                        .padding(.horizontal, horizontalGridPadding)
                    Text("You'll notice that within the grid there are nine squares shown with bold borders. Below is one square highlighted in yellow. The third requirement is that each of these squares must also only contain the numbers 1 through 9, once per digit.")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .square, grid: GridFactory.easyGrid)
                        .padding(.horizontal, horizontalGridPadding)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("If all three conditions are met, then the Sudoku grid has been solved.")
                        Text("The difficulty of a Sudoku puzzle can range depending on how many digits are already filled in at the beginning. Good luck and have fun solving them!")
                    }
                    .padding(.horizontal, horizontalTextPadding)
                }
                .padding(.top, 8)
                .padding(.bottom, 24)
                .padding(.horizontal, horizontalContainerPadding)
            }
            .font(Font.system(.headline, design: .rounded))
            .fullBackgroundStyle()
            .navigationTitle("How to play")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        HowToPlayView()
            .environment(WindowSize(size: geometry.size))
    }
}
