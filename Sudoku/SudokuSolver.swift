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

    /// Creates a full 9x9 grid with empty cells marked as nil
    static func createFullGrid(_ partialGrid: [CoordinateValue]) -> [[CoordinateValue?]] {
        var fullGrid = Array(repeating: Array(repeating: nil as CoordinateValue?, count: 9), count: 9)
        let convertedGrid = convertGrid(partialGrid)
        
        // Fill in the known values
        for value in convertedGrid {
            fullGrid[value.r][value.c] = value
        }
        
        return fullGrid
    }

    /// Finds naked and hidden singles in the grid
    /// - Parameter gridValues: The current state of the Sudoku grid
    /// - Returns: Array of tuples containing coordinate and description of found singles
    static func findSingles(_ gridValues: [CoordinateValue]) -> [(coordinate: CoordinateValue, description: String)] {
        var singles: [(CoordinateValue, String)] = []
        let fullGrid = createFullGrid(gridValues)
        let convertedGrid = convertGrid(gridValues)
        
        // Check each cell in the grid
        for row in 0..<9 {
            for col in 0..<9 {
                // Skip filled cells
                if fullGrid[row][col] != nil { continue }
                
                // Calculate square index
                let squareIndex = (row / 3) * 3 + (col / 3)
                
                // Get all values in the same row, column, and square
                let rowValues = convertedGrid.filter { $0.r == row }.map { $0.v }
                let colValues = convertedGrid.filter { $0.c == col }.map { $0.v }
                let squareValues = convertedGrid.filter { $0.s == squareIndex }.map { $0.v }
                
                // Find possible values for this cell
                let allPossible = Set(1...9)
                let usedValues = Set(rowValues + colValues + squareValues)
                let possibleValues = allPossible.subtracting(usedValues)
                
                // Check for naked single (only one possible value)
                if possibleValues.count == 1 {
                    if let value = possibleValues.first {
                        let nakedSingle = CoordinateValue(r: row, c: col, s: squareIndex, v: value)
                        singles.append((nakedSingle, "There is at least one naked single on this board. Can you find it?"))
                    }
                }
                
                // Check for hidden single in row, column, and square
                for value in 1...9 {
                    if !usedValues.contains(value) {
                        let emptyCellsInRow = (0..<9).filter { fullGrid[row][$0] == nil }.count
                        let emptyCellsInCol = (0..<9).filter { fullGrid[$0][col] == nil }.count
                        let squareStartRow = (row / 3) * 3
                        let squareStartCol = (col / 3) * 3
                        let emptyCellsInSquare = (squareStartRow..<squareStartRow+3).flatMap { r in
                            (squareStartCol..<squareStartCol+3).map { c in
                                fullGrid[r][c] == nil
                            }
                        }.filter { $0 }.count
                        
                        let isHiddenInRow = emptyCellsInRow == 1
                        let isHiddenInCol = emptyCellsInCol == 1
                        let isHiddenInSquare = emptyCellsInSquare == 1
                        
                        if isHiddenInRow || isHiddenInCol || isHiddenInSquare {
                            let hiddenSingle = CoordinateValue(r: row, c: col, s: squareIndex, v: value)
                            let location = isHiddenInRow ? "row" : (isHiddenInCol ? "column" : "square")
                            singles.append((hiddenSingle, "There is a hidden single on this board. Can you find it?"))
                        }
                    }
                }
            }
        }
        
        return singles
    }
}
