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

        let indexRange = (0...8)

        // check each 3x3 square
        for squareIndex in indexRange {
            let squareValues = gridValues.values(in: squareIndex)
            if SudokuSolver.validate(values: squareValues) == false {
                return false
            }
        }

        // check each full row
        let gridConverted = convertGrid(grid)
        for rowIndex in indexRange {
            let rowValues = gridConverted.filter { $0.r == rowIndex }
            if SudokuSolver.validate(values: rowValues) == false {
                return false
            }
        }

        // check each full column
        for colIndex in indexRange {
            let colValues = gridConverted.filter { $0.c == colIndex }
            if SudokuSolver.validate(values: colValues) == false {
                return false
            }
        }

        return true
    }

    /// Checks whether the array of values contains any duplicates–returns false if there are.
    static func validate<T: Hashable>(values: [T]) -> Bool {
        var set = Set<T>()

        for value in values {
            if set.insert(value).inserted == false {
                return false
            }
        }
        return true
    }

    static func convertGrid(_ grid: [CoordinateValue]) -> [AbsoluteCoordinateValue] {
        return grid.map { coordinateValue -> AbsoluteCoordinateValue in
            let absoluteRow = convertToFullRowIndex(rowIndex: coordinateValue.r, squareIndex: coordinateValue.s)
            let absoluteCol = convertToFullColIndex(colIndex: coordinateValue.c, squareIndex: coordinateValue.s)
            return AbsoluteCoordinateValue(r: absoluteRow, c: absoluteCol, v: coordinateValue.v)
        }
    }

    /// Note: Square indices ascend from left to right, top to bottom of grid. For example,
    /// top-left square in grid has square index 0, top-center square has index 1, top-right
    /// square has index 2, mid-left square has index 3, etc.
    static func convertToFullRowIndex(rowIndex: Int, squareIndex: Int) -> Int {
        if squareIndex > 2 && squareIndex < 6 {
            return rowIndex + 3
        } else if squareIndex > 6 {
            return rowIndex + 6
        } else {
            return rowIndex
        }
    }

    /// Note: Square indices ascend from left to right, top to bottom of grid. For example,
    /// top-left square in grid has square index 0, top-center square has index 1, top-right
    /// square has index 2, mid-left square has index 3, etc.
    static func convertToFullColIndex(colIndex: Int, squareIndex: Int) -> Int {
        if [1, 4, 7].contains(squareIndex) {
            return colIndex + 3
        } else if [2, 5, 8].contains(squareIndex) {
            return colIndex + 6
        } else {
            return colIndex
        }
    }
}
