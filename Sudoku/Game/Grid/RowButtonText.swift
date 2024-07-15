//
//  RowButtonText.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/3/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct RowButtonText: View {
    
    @Environment(WindowSize.self) var windowSize
    
    let text: String
    let foregroundColor: Color

    private var buttonTextFont: Font {
        let textStyle: Font.TextStyle = isIpad ? .largeTitle : .title
        return Font.system(textStyle, design: .rounded).bold()
    }

    private var buttonMinHeight: CGFloat {
        (windowSize.size.width - (2 * SudokuGrid.spacerWidth)) / 9
    }

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(buttonTextFont)
            .frame(maxWidth: .infinity, minHeight: buttonMinHeight)
    }
}

#Preview {
    GeometryReader { geometry in
        VStack {
            RowButtonText(text: "1", foregroundColor: .black)
                .environment(WindowSize(size: geometry.size))
            RowButtonText(text: "", foregroundColor: .black)
                .environment(WindowSize(size: geometry.size))
        }
    }
}
