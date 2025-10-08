//
//  HowToPlayView.swift
//  Sudoku
//
//  Created by Ray Kim on 3/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct HowToPlayView: View {

    private var horizontalTextPadding: CGFloat {
        isIphone ? 12 : 0
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("how-to-play.overview")
                        Text("how-to-play.explainer-first")
                    }
                    .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .row, grid: GridFactory.easyGrid)
                    Text("how-to-play.explainer-second")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .column, grid: GridFactory.easyGrid)
                    Text("how-to-play.explainer-third")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .square, grid: GridFactory.easyGrid)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("how-to-play.explainer-fourth")
                    }
                    .padding(.horizontal, horizontalTextPadding)
                }
                .padding(.top, 8)
                .padding(.bottom, 24)
                .padding(.horizontal, getContainerHorizontalPadding(geometry.size))
            }
            .font(Font.system(.headline, design: .rounded))
            .fullBackgroundStyle()
            .navigationTitle("how-to-play.title")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func getContainerHorizontalPadding(_ size: CGSize) -> CGFloat {
        if isIphone {
            return 4
        } else if size.height >= size.width { // portrait or square
            return 24
        } else { // landscape
            return 140
        }
    }
}

#Preview {
    GeometryReader { geometry in
        HowToPlayView()
            .environment(WindowSize(size: geometry.size))
    }
}
