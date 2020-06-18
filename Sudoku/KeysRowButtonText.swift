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

    private var textHeight: CGFloat {
        isIpad ? 60 : 48
    }
    private let textFont = Font.system(.title, design: .rounded)

    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .font(textFont)
            .frame(maxWidth: .infinity, minHeight: textHeight)
            .background(Color("dynamicGray"))
    }
}
