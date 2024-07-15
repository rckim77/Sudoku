//
//  RowButtonText.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/3/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct RowButtonText: View {
    
    let text: String
    let foregroundColor: Color

    private var buttonTextFont: Font {
        let textStyle: Font.TextStyle = isIpad ? .largeTitle : .title
        return Font.system(textStyle, design: .rounded).bold()
    }

    private var buttonMinHeight: CGFloat {
        (screenWidth - (2 * SudokuGrid.spacerWidth)) / 9
    }

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(buttonTextFont)
            .frame(maxWidth: .infinity, minHeight: buttonMinHeight)
    }
}

#Preview {
    VStack {
        RowButtonText(text: "1", foregroundColor: .black)
        RowButtonText(text: "", foregroundColor: .black)
    }
}
