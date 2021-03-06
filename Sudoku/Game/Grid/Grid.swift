//
//  Grid.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Grid: View {
    
    let startingGrid: [CoordinateValue]
    let workingGrid: [CoordinateValue]
    let editGrid: [CoordinateEditValues]
    let colorGrid: [CoordinateColor]
    
    static var spacerWidth: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 80
        } else {
            return 8
        }
    }
    
    private var borderWidth: CGFloat {
        screenHeight > 667 ? 3 : 2
    }
    private let squareRowRanges = [(0...2), (3...5), (6...8)]

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: Grid.spacerWidth)
            VStack {
                ForEach(squareRowRanges, id: \.self) { squareRowRange in
                    HStack(spacing: 0) {
                        ForEach(squareRowRange, id: \.self) { squareIndex in
                            Square(index: squareIndex,
                                   startingGrid: self.startingGrid,
                                   workingGridSlice: self.workingGrid.filter { $0.s == squareIndex },
                                   editGridSlice: self.editGrid.filter { $0.s == squareIndex },
                                   colorGridSlice: self.colorGrid.filter { $0.s == squareIndex })
                        }
                    }
                }
            }
            .padding(borderWidth)
            .border(Color.black, width: borderWidth)
            Spacer()
                .frame(width: Grid.spacerWidth)
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(startingGrid: GridFactory.easyGrid,
             workingGrid: GridFactory.easyGrid,
             editGrid: [],
             colorGrid: [])
    }
}
