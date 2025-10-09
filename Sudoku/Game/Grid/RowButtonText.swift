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
            .minimumScaleFactor(0.45)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
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
