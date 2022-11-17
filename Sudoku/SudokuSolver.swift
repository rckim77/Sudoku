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

        let indexRange = (0...8)

        // check each 3x3 square
        for squareIndex in indexRange {
            let squareValues = gridValues.values(in: squareIndex, grid: gridValues.grid)
            if !SudokuSolver.validate(squareValues) {
                return false
            }
        }

        // check each full row
        let gridConverted = convertGrid(grid)
        for rowIndex in indexRange {
            let rowValues = gridConverted.filter { $0.r == rowIndex }
            if !SudokuSolver.validate(rowValues) {
                return false
            }
        }

        // check each full column
        for colIndex in indexRange {
            let colValues = gridConverted.filter { $0.c == colIndex }
            if !SudokuSolver.validate(colValues) {
                return false
            }
        }

        return true
    }

    /// Checks whether the array of values contains any duplicates–returns false if there are.
    static func validate(_ coordinateValues: [CoordinateValue]) -> Bool {
        var set = Set<Int>()
        
        let values = coordinateValues.map { $0.v }
        for value in values {
            if set.insert(value).inserted == false {
                return false
            }
        }
        return true
    }

    /// Transforms relative coordinate value grid to absolute coordinate value grid.
    static func convertGrid(_ grid: [CoordinateValue]) -> [CoordinateValue] {
        return grid.map {
            let absoluteRow = convertToFullRowIndex(rowIndex: $0.r, squareIndex: $0.s)
            let absoluteCol = convertToFullColIndex(colIndex: $0.c, squareIndex: $0.s)
            return CoordinateValue(r: absoluteRow, c: absoluteCol, s: $0.s, v: $0.v)
        }
    }

    /// Note: Square indices ascend from left to right, top to bottom of grid. For example,
    /// top-left square in grid has square index 0, top-center square has index 1, top-right
    /// square has index 2, mid-left square has index 3, etc.
    static func convertToFullRowIndex(rowIndex: Int, squareIndex: Int) -> Int {
        if squareIndex > 2 && squareIndex < 6 {
            return rowIndex + 3
        } else if squareIndex >= 6 {
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
