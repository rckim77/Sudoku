//
//  SudokuSolver.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/12/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct SudokuSolver {
    static func gridIsSolved(_ gridValues: GridValues) -> Bool {
        let grid = gridValues.grid
        guard grid.count == 81 else {
            return false
        }

        // check each 3x3 square
        let squareIndices = (0...8)
        for squareIndex in squareIndices {
            let squareValues = gridValues.values(in: squareIndex)
            if SudokuSolver.validate(values: squareValues) == false {
                return false
            }
        }

        // check each full row

        // check each full column

        return true
    }

    /// Checks whether the array of values contains any duplicates–returns false if there are.
    static func validate(values: [CoordinateValue]) -> Bool {
        var set = Set<CoordinateValue>()

        for value in values {
            if set.insert(value).inserted == false {
                return false
            }
        }
        return true
    }
}
