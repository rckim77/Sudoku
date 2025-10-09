//
//  KeysRowButtonText.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/4/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct KeysRowButtonText: View {

    let text: String
    let isCompact: Bool

    private var textHeight: CGFloat {
        isCompact ? 48 : 74
    }
    private var textFont: Font {
        let textStyle: Font.TextStyle = isCompact ? .title : .largeTitle
        return Font.system(textStyle, design: .rounded)
    }

    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .font(textFont)
            .frame(maxWidth: .infinity, minHeight: textHeight)
    }
}

#Preview {
    KeysRowButtonText(text: "1", isCompact: false)
}
