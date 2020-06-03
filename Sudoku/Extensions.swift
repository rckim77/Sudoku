//
//  Extensions.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct Extensions_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Text("Test")
                .padding()
                .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                .border(Color.black, width: 2)
        }
    }
}
