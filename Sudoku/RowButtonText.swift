//
//  RowButtonText.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/3/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct RowButtonText: View {

    private let buttonTextFont = Font.system(.title, design: .rounded).bold()
    private let buttonVerticalPadding: CGFloat = 6
    let text: String
    let foregroundColor: Color

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(buttonTextFont)
            .padding(.vertical, buttonVerticalPadding)
            .frame(maxWidth: .infinity, minHeight: 45.5)
    }
}

struct RowButtonText_Previews: PreviewProvider {
    static var previews: some View {
        RowButtonText(text: "1", foregroundColor: .black)
    }
}
