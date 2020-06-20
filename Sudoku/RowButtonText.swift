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
    private var buttonVerticalPadding: CGFloat {
         let screenHeight = UIScreen.main.bounds.height
        if isIpad {
            return 16
        } else if screenHeight > 667 {
            return 6
        } else {
            return 3
        }
    }
    private var buttonMinHeight: CGFloat {
         let screenHeight = UIScreen.main.bounds.height
        if isIpad {
            return 65.5
        } else if screenHeight > 667 {
            return 45.5
        } else {
            return 39.5
        }
    }
    let text: String
    let foregroundColor: Color

    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(buttonTextFont)
            .padding(.vertical, buttonVerticalPadding)
            .frame(maxWidth: .infinity, minHeight: buttonMinHeight)
    }
}

struct RowButtonText_Previews: PreviewProvider {
    static var previews: some View {
        RowButtonText(text: "1", foregroundColor: .black)
    }
}
