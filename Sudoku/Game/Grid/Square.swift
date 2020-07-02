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
    let startingGrid: [CoordinateValue]
    let workingGridSlice: [CoordinateValue]
    let editGridSlice: [CoordinateEditValues]
    let colorGridSlice: [CoordinateColor]
    
    private let viewModel = SquareViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.rowIndices, id: \.self) { rowIndex in
                Row(viewModel: RowViewModel(index: rowIndex,
                                            squareIndex: self.index,
                                            startingGrid: self.startingGrid,
                                            workingGrid: self.workingGridSlice.filter { $0.r == rowIndex },
                                            colorGrid: self.colorGridSlice.filter { $0.r == rowIndex },
                                            guesses: self.editGridSlice.filter { $0.r == rowIndex }))
            }
        }
        .border(Color.black, width: viewModel.borderWidth)
    }
}

struct Square_Previews: PreviewProvider {
    static var previews: some View {
        Square(index: 0,
               startingGrid: GridFactory.easyGrid,
               workingGridSlice: GridFactory.easyGrid.filter { $0.s == 0 },
               editGridSlice: [],
               colorGridSlice: [])
    }
}
