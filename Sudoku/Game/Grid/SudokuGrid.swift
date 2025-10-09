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
    
    /// This width value affects the row text height and the edit cell grid height, which will resize and scale
    /// the overall grid's height accordingly. Update `getSpacerWidth(screenSize:)` when
    /// updating this var if applicable.
    static var spacerWidth: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return 8
        default: return 160
        }
    }
    
    private let borderWidth: CGFloat = 2
    private let squareRowRanges = [(0...2), (3...5), (6...8)]

    var body: some View {
        GeometryReader { geometry in
            GridContainerView { squareIndex in
                Square(index: squareIndex,
                       editGridSlice: self.editGrid.filter { $0.s == squareIndex },
                       selectedCell: selectedCell,
                       userAction: userAction,
                       workingGrid: workingGrid)
            }
            .padding(.horizontal, getSpacerWidth(size: geometry.size))
        }
    }
    
    /// This width value determines how much space there is padded on the sides of
    /// the sudoku grid. The grid will resize and scale accordingly. Note that
    /// `size` is relative to the grid, not the entire window.
    private func getSpacerWidth(size: CGSize) -> CGFloat {
        if isIphone {
            return 8
        } else { // maintain square aspect ratio
            let spacing = abs(size.width - size.height) / 2

            if size.width < size.height {
                return 16
            }
            return spacing
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
