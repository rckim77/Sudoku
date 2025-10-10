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
    
    private let widthThreshold: CGFloat = 600

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
                        .padding(.horizontal, getGridHorizontalPadding(geometry.size))
                    Text("how-to-play.explainer-second")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .column, grid: GridFactory.easyGrid)
                        .padding(.horizontal, getGridHorizontalPadding(geometry.size))
                    Text("how-to-play.explainer-third")
                        .padding(.horizontal, horizontalTextPadding)
                    StaticGridView(highlightSection: .square, grid: GridFactory.easyGrid)
                        .padding(.horizontal, getGridHorizontalPadding(geometry.size))
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
        } else if size.width < widthThreshold { // not a lot of horizontal space
            return 24
        } else { // lots of horizontal space
            return 140
        }
    }

    private func getGridHorizontalPadding(_ size: CGSize) -> CGFloat {
        if isIphone {
            return 0
        } else if size.width < widthThreshold {
            return 0
        } else {
            return 48
        }
    }
}

#Preview {
    GeometryReader { geometry in
        HowToPlayView()
            .environment(WindowSize(size: geometry.size))
    }
}
