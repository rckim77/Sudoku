//
//  RowButtonText.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/3/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct RowButtonText: View {
    
    @Environment(WindowSize.self) private var windowSize
    
    let text: String
    let foregroundColor: Color
    let isStatic: Bool

    private var buttonTextFont: Font {
        let textStyle: Font.TextStyle = isIpad ? .largeTitle : .title
        return Font.system(textStyle, design: .rounded).bold()
    }

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(buttonTextFont)
            .frame(maxWidth: .infinity)
            .frame(height: getHeight(size: windowSize.size))
    }
    
    private func getHeight(size: CGSize) -> CGFloat {
        if isStatic {
            return (windowSize.size.width - (2 * StaticGridView.spacerWidth)) / 9
        }
        
        if isVision {
            let horizontalPadding = abs(size.width - size.height)
            let extraVerticalOffset: CGFloat = 24 // other UI elements below the grid
            return ((size.width - horizontalPadding) / 9) - extraVerticalOffset
        } else {
            return (windowSize.size.width - (2 * SudokuGrid.spacerWidth)) / 9
        }
    }
}

#Preview {
    GeometryReader { geometry in
        VStack {
            RowButtonText(text: "1", foregroundColor: .black, isStatic: true)
                .environment(WindowSize(size: geometry.size))
            RowButtonText(text: "", foregroundColor: .black, isStatic: true)
                .environment(WindowSize(size: geometry.size))
        }
    }
}
