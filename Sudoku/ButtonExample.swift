//
//  ButtonExample.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ButtonExample: View {
    @State
    private var showDarkBackground = false

    var body: some View {
        Button(action: {
            self.showDarkBackground.toggle()
        }) {
            Text(showDarkBackground ? "Show light" : "Show dark")
                .foregroundColor(showDarkBackground ? Color.white : Color.blue)
        }
        .padding(12)
        .background(showDarkBackground ? Color.black : Color.white)
        .cornerRadius(8)
    }
}

struct ButtonExample_Preview: PreviewProvider {
    static var previews: some View {
        ButtonExample()
    }
}
