//
//  EditCellGridText.swift
//  Sudoku
//
//  Created by Ray Kim on 6/29/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct EditCellGridText: View {

    let digitText: String
    
    private var font: Font.TextStyle {
        isIpad ? .headline : .footnote
    }

    var body: some View {
        Text(digitText)
            .foregroundColor(Color("dynamicBlue"))
            .font(.system(font, design: .rounded))
            .frame(maxWidth: .infinity)
    }
}

struct EditCellGridText_Previews: PreviewProvider {
    static var previews: some View {
        EditCellGridText(digitText: "0")
    }
}
