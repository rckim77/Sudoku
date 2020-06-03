//
//  Square.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Square: View {
    let index: Int

    private let columns = [0, 1, 2]

    var body: some View {
        VStack(alignment: .leading) {
            Row(index: 0, columns: columns, squareIndex: index)
            Row(index: 1, columns: columns, squareIndex: index)
            Row(index: 2, columns: columns, squareIndex: index)
        }
        .border(Color.black, width: 3)
    }
}

struct Square_Previews: PreviewProvider {
    static var previews: some View {
        Square(index: 0)
    }
}
