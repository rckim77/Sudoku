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

    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .font(buttonTextFont)
            .padding(.vertical, buttonVerticalPadding)
            .frame(maxWidth: .infinity, minHeight: 45)
    }
}
