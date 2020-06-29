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

    private let buttonTextFont = Font.system(.title, design: .rounded).bold()

    private var buttonMinHeight: CGFloat {
        (screenWidth - (2 * Grid.spacerWidth)) / 9
    }

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(buttonTextFont)
            .frame(maxWidth: .infinity, minHeight: buttonMinHeight)
    }
}

struct RowButtonText_Previews: PreviewProvider {
    static var previews: some View {
        RowButtonText(text: "1", foregroundColor: .black)
    }
}
