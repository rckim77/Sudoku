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
    let editGridSlice: [CoordinateEditValues]
    
    private let viewModel = SquareViewModel()

    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(viewModel.rowIndices, id: \.self) { rowIndex in
                Row(viewModel: RowViewModel(index: rowIndex,
                                            squareIndex: self.index,
                                            guesses: self.editGridSlice.filter { $0.r == rowIndex }))
            }
        }
        .border(Color.black, width: viewModel.borderWidth)
    }
}

struct Square_Previews: PreviewProvider {
    static var previews: some View {
        Square(index: 0,
               editGridSlice: [])
    }
}
