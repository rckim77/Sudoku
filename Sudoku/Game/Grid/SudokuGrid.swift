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
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: getSpacerWidth(screenSize: geometry.size))
                GridContainerView { squareIndex in
                    Square(index: squareIndex,
                           editGridSlice: self.editGrid.filter { $0.s == squareIndex },
                           selectedCell: selectedCell,
                           userAction: userAction,
                           workingGrid: workingGrid)
                }
                Spacer()
                    .frame(width: getSpacerWidth(screenSize: geometry.size))
            }
        }
    }
    
    private func getSpacerWidth(screenSize: CGSize) -> CGFloat {
        if isIphone {
            return 8
        } else if isVision {
            // maintain square aspect ratio
            return (screenSize.width - screenSize.height) / 2
        } else {
            return 160
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
