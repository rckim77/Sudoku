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
                        Text("howto_intro")
                        Text("howto_rule_rows")
                    }
                    .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .row, grid: GridFactory.easyGrid)
                        .padding(.horizontal, horizontalGridPadding)
                    Text("howto_rule_columns")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .column, grid: GridFactory.easyGrid)
                        .padding(.horizontal, horizontalGridPadding)
                    Text("howto_rule_squares")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .square, grid: GridFactory.easyGrid)
                        .padding(.horizontal, horizontalGridPadding)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("howto_conclusion_1")
                        Text("howto_conclusion_2")
                    }
                    .padding(.horizontal, horizontalTextPadding)
                }
                .padding(.top, 8)
                .padding(.bottom, 24)
                .padding(.horizontal, horizontalContainerPadding)
            }
            .font(Font.system(.headline, design: .rounded))
            .fullBackgroundStyle()
            .navigationTitle("howto_title")
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
