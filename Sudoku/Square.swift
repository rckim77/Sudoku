//
//  Square.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Square: View {
    var body: some View {
        VStack(alignment: .leading) {
            Row()
            Row()
            Row()
        }
        .border(Color.black, width: 3)
    }
}

struct Square_Previews: PreviewProvider {
    static var previews: some View {
        Square()
    }
}
