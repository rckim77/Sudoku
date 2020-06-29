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
        8
    }

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: Grid.spacerWidth)
            VStack {
                HStack(spacing: 0) {
                    Square(index: 0,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 0 },
                           editGridSlice: editGrid.filter { $0.s == 0 },
                           colorGridSlice: colorGrid.filter { $0.s == 0 })
                    Square(index: 1,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 1 },
                           editGridSlice: editGrid.filter { $0.s == 1 },
                           colorGridSlice: colorGrid.filter { $0.s == 1 })
                    Square(index: 2,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 2 },
                           editGridSlice: editGrid.filter { $0.s == 2 },
                           colorGridSlice: colorGrid.filter { $0.s == 2 })
                }
                HStack(spacing: 0) {
                    Square(index: 3,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 3 },
                           editGridSlice: editGrid.filter { $0.s == 3 },
                           colorGridSlice: colorGrid.filter { $0.s == 3 })
                    Square(index: 4,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 4 },
                           editGridSlice: editGrid.filter { $0.s == 4 },
                           colorGridSlice: colorGrid.filter { $0.s == 4 })
                    Square(index: 5,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 5 },
                           editGridSlice: editGrid.filter { $0.s == 5 },
                           colorGridSlice: colorGrid.filter { $0.s == 5 })
                }
                HStack(spacing: 0) {
                    Square(index: 6,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 6 },
                           editGridSlice: editGrid.filter { $0.s == 6 },
                           colorGridSlice: colorGrid.filter { $0.s == 6 })
                    Square(index: 7,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 7 },
                           editGridSlice: editGrid.filter { $0.s == 7 },
                           colorGridSlice: colorGrid.filter { $0.s == 7 })
                    Square(index: 8,
                           startingGrid: startingGrid,
                           workingGridSlice: workingGrid.filter { $0.s == 8 },
                           editGridSlice: editGrid.filter { $0.s == 8 },
                           colorGridSlice: colorGrid.filter { $0.s == 8 })
                }
            }
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
