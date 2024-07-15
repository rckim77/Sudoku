//
//  SudokuGrid.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct SudokuGrid: View {

    var selectedCell: SelectedCell
    var userAction: UserAction
    let editGrid: [CoordinateEditValues]
    let workingGrid: GridValues
    
    /// This width value determines how much space there is padded on the sides of
    /// the sudoku grid. The grid will resize and scale accordingly.
    static var spacerWidth: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 8
        } else {
            return 160
        }
    }
    
    private let borderWidth: CGFloat = 2
    private let squareRowRanges = [(0...2), (3...5), (6...8)]

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: SudokuGrid.spacerWidth)
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(squareRowRanges, id: \.self) { squareRowRange in
                    GridRow {
                        ForEach(squareRowRange, id: \.self) { squareIndex in
                            Square(index: squareIndex,
                                   editGridSlice: self.editGrid.filter { $0.s == squareIndex },
                                   selectedCell: selectedCell,
                                   userAction: userAction,
                                   workingGrid: workingGrid)
                        }
                    }
                }
            }
            .padding(borderWidth)
            .border(Color.black, width: borderWidth)
            Spacer()
                .frame(width: SudokuGrid.spacerWidth)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        SudokuGrid(selectedCell: SelectedCell(),
                   userAction: UserAction(),
                   editGrid: [],
                   workingGrid: GridValues.init(startingGrid: GridFactory.easyGrid))
        .environment(WindowSize(size: geometry.size))
    }
}
