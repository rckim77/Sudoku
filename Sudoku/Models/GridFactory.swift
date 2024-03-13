//
//  GridFactory.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/18/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

/// (row, column, value)–square is implied by order of square arrays in array
typealias ShortCoordinate = (Int, Int, Int)

enum GridFactory {

    static func randomGridForDifficulty(level: Difficulty.Level) -> [CoordinateValue] {
        let randomNumber = Int.random(in: 0...2)
        switch level {
        case .easy:
            let easyGrids = [easyGrid, easyGrid1, easyGrid2]
            return easyGrids[randomNumber]
        case .medium:
            let mediumGrids = [mediumGrid, mediumGrid1, mediumGrid2]
            return mediumGrids[randomNumber]
        case .hard:
            let hardGrids = [hardGrid, hardGrid1, hardGrid2]
            return hardGrids[randomNumber]
        }
    }
    
    // MARK: - grids
    
    /// FOR TESTING
    static var superEasyGrid: [CoordinateValue] {
        let square0 = [(0, 0, 9), (0, 1, 6), (0, 2, 2), (1, 0, 1), (1, 1, 8), (1, 2, 5), (2, 0, 3), (2, 1, 7), (2, 2, 4)]
        let square1 = [(0, 0, 3), (0, 1, 7), (0, 2, 8), (1, 0, 4), (1, 1, 2), (1, 2, 9), (2, 0, 5), (2, 1, 6), (2, 2, 1)]
        let square2 = [(0, 0, 4), (0, 1, 1), (0, 2, 5), (1, 0, 7), (1, 1, 6), (1, 2, 3), (2, 0, 9), (2, 1, 2), (2, 2, 8)]
        let square3 = [(0, 0, 4), (0, 1, 9), (0, 2, 6), (1, 0, 2), (1, 1, 1), (1, 2, 8), (2, 0, 7), (2, 1, 5), (2, 2, 3)]
        let square4 = [(0, 0, 8), (0, 1, 3), (0, 2, 2), (1, 0, 7), (1, 2, 5), (2, 1, 9), (2, 2, 6)]
        let square5 = [(0, 0, 1), (0, 1, 5), (0, 2, 7), (1, 1, 9), (2, 0, 2), (2, 1, 8), (2, 2, 4)]
        let square6 = [(0, 0, 5), (0, 1, 3), (0, 2, 1), (1, 0, 8), (1, 1, 2), (1, 2, 7), (2, 0, 6), (2, 1, 4), (2, 2, 9)]
        let square7 = [(0, 0, 9), (0, 1, 8), (0, 2, 4), (1, 0, 6), (1, 1, 1), (1, 2, 3), (2, 0, 2), (2, 1, 5), (2, 2, 7)]
        let square8 = [(0, 0, 6), (0, 1, 7), (0, 2, 2), (1, 0, 5), (1, 1, 4), (1, 2, 9), (2, 1, 3), (2, 2, 1)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }

    static var easyGrid: [CoordinateValue] {
        let square0 = [(0, 0, 8), (1, 1, 9), (2, 0, 5), (2, 1, 7), (2, 2, 1)]
        let square1 = [(0, 0, 9), (0, 1, 5), (1, 0, 2), (1, 2, 8), (2, 0, 3), (2, 2, 6)]
        let square2 = [(0, 0, 4), (0, 1, 6), (0, 2, 1), (1, 0, 5), (1, 1, 3), (1, 2, 7), (2, 1, 9)]
        let square3 = [(0, 0, 1), (1, 1, 6), (1, 2, 2), (2, 0, 9), (2, 2, 5)]
        let square4 = [(0, 0, 6), (1, 0, 5), (1, 2, 9), (2, 1, 7), (2, 2, 1)]
        let square5 = [(0, 0, 9), (1, 1, 7), (2, 2, 3)]
        let square6 = [(0, 0, 2), (0, 2, 8), (1, 2, 4), (2, 0, 7), (2, 1, 3)]
        let square7 = [(0, 0, 7), (0, 2, 5), (1, 0, 8), (1, 2, 3), (2, 0, 1), (2, 2, 4)]
        let square8 = [(0, 0, 3), (0, 2, 6), (1, 1, 1), (2, 1, 5), (2, 2, 2)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }
    
    static var easyGrid1: [CoordinateValue] {
        let square0 = [(0, 1, 6), (1, 0, 1), (1, 1, 8), (1, 2, 5)]
        let square1 = [(0, 0, 3), (1, 1, 2), (2, 0, 5)]
        let square2 = [(0, 0, 4), (0, 1, 1), (1, 0, 7), (1, 2, 3), (2, 0, 9), (2, 1, 2), (2, 2, 8)]
        let square3 = [(0, 1, 9), (0, 2, 6), (1, 0, 2), (1, 1, 1), (2, 1, 5)]
        let square4 = [(0, 0, 8), (0, 2, 2), (1, 1, 4), (2, 2, 6)]
        let square5 = [(0, 1, 5), (0, 2, 7), (1, 0, 3), (2, 1, 8), (2, 2, 4)]
        let square6 = [(0, 0, 5), (2, 2, 9)]
        let square7 = [(0, 2, 4), (1, 0, 6), (1, 1, 1), (1, 2, 3), (2, 2, 7)]
        let square8 = [(0, 0, 6), (1, 0, 5), (1, 1, 4)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }
    
    static var easyGrid2: [CoordinateValue] {
        let square0 = [(0, 0, 6), (1, 0, 7), (1, 2, 4), (2, 0, 2), (2, 1, 1)]
        let square1 = [(0, 0, 4), (0, 1, 7), (1, 1, 6), (1, 2, 2), (2, 0, 5)]
        let square2 = [(0, 0, 3), (0, 2, 1), (1, 1, 8), (1, 2, 5), (2, 2, 7)]
        let square3 = [(0, 1, 2), (0, 2, 6), (1, 2, 3), (2, 0, 8), (2, 2, 1)]
        let square4 = [(0, 0, 3), (0, 1, 4), (1, 1, 9), (1, 2, 1)]
        let square5 = [(1, 0, 5), (1, 2, 2), (2, 0, 4)]
        let square6 = [(0, 0, 5), (0, 2, 8), (1, 1, 4), (2, 0, 1), (2, 1, 9)]
        let square7 = [(0, 1, 1), (1, 0, 6), (2, 0, 2)]
        let square8 = [(1, 2, 9), (2, 0, 8), (2, 1, 3)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }

    static var mediumGrid: [CoordinateValue] {
        let square0 = [(0, 0, 1), (0, 2, 2), (1, 0, 3), (1, 1, 9)]
        let square1 = [(0, 0, 8), (2, 1, 1)]
        let square2 = [(0, 2, 6), (1, 0, 8), (2, 2, 3)]
        let square3 = [(0, 2, 7), (1, 1, 6)]
        let square4 = [(0, 0, 1), (0, 2, 3), (1, 0, 2), (1, 1, 7), (1, 2, 4), (2, 0, 6), (2, 2, 5)]
        let square5 = [(1, 1, 5), (2, 0, 1)]
        let square6 = [(0, 0, 6), (1, 2, 5), (2, 0, 4)]
        let square7 = [(0, 1, 4), (2, 2, 1)]
        let square8 = [(1, 1, 2), (1, 2, 1), (2, 0, 6), (2, 2, 7)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }
    
    static var mediumGrid1: [CoordinateValue] {
        let square0 = [(0, 2, 4), (1, 0, 7), (1, 2, 2), (2, 0, 8)]
        let square1 = [(0, 1, 7), (1, 0, 9), (1, 1, 4), (1, 2, 3), (2, 2, 2)]
        let square2 = [(0, 0, 2), (0, 2, 6)]
        let square3 = [(1, 1, 2), (2, 1, 9)]
        let square4 = [(1, 2, 5), (2, 1, 3)]
        let square5 = [(1, 0, 3), (2, 1, 6), (2, 2, 5)]
        let square6 = [(0, 0, 9), (0, 2, 1), (1, 2, 8)]
        let square7 = [(0, 0, 7), (0, 1, 2), (0, 2, 4), (1, 0, 5), (1, 2, 9)]
        let square8 = [(0, 0, 6), (0, 1, 5), (1, 0, 4), (1, 2, 2)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }
    
    static var mediumGrid2: [CoordinateValue] {
        let square0 = [(0, 1, 6), (1, 2, 2), (2, 2, 7)]
        let square1 = [(0, 0, 3), (0, 2, 7), (1, 0, 6), (1, 2, 4), (2, 1, 8)]
        let square2 = [(1, 0, 1), (2, 0, 2)]
        let square3 = [(0, 0, 6), (0, 2, 8), (1, 0, 9), (2, 0, 5), (2, 1, 4)]
        let square4: [Coordinate] = []
        let square5 = [(0, 1, 9), (0, 2, 4), (1, 2, 1), (2, 0, 3), (2, 2, 2)]
        let square6 = [(0, 2, 6), (1, 2, 9)]
        let square7 = [(0, 1, 7), (1, 0, 2), (1, 2, 6), (2, 0, 9), (2, 2, 8)]
        let square8 = [(0, 0, 4), (1, 0, 8), (2, 1, 2)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }

    static var hardGrid: [CoordinateValue] {
        let square0 = [(0, 1, 1), (1, 0, 5), (1, 2, 3), (2, 0, 4)]
        let square1 = [(2, 0, 7), (2, 1, 1)]
        let square2 = [(0, 1, 3), (1, 2, 8), (2, 2, 9)]
        let square3 = [(0, 1, 9), (1, 2, 6)]
        let square4 = [(0, 0, 6), (1, 0, 5), (1, 2, 2), (2, 2, 9)]
        let square5 = [(1, 0, 9), (2, 1, 8)]
        let square6 = [(0, 0, 7), (1, 0, 1), (2, 1, 6)]
        let square7 = [(0, 1, 4), (0, 2, 5)]
        let square8 = [(0, 2, 1), (1, 0, 3), (1, 2, 2), (2, 1, 5)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }
    
    static var hardGrid1: [CoordinateValue] {
        let square0 = [(0, 2, 1), (1, 1, 9), (2, 1, 8)]
        let square1 = [(0, 1, 4), (0, 2, 6), (1, 2, 8), (2, 0, 5)]
        let square2 = [(0, 2, 2)]
        let square3 = [(1, 0, 1), (1, 1, 3), (1, 2, 8), (2, 1, 7), (2, 2, 6)]
        let square4 = [(0, 0, 2), (2, 0, 3)]
        let square5 = [(1, 1, 5)]
        let square6 = [(0, 1, 1), (1, 0, 3)]
        let square7 = [(0, 1, 9), (1, 2, 5)]
        let square8 = [(0, 2, 8), (1, 0, 4), (1, 1, 2), (2, 1, 6), (2, 2, 1)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }
    
    static var hardGrid2: [CoordinateValue] {
        let square0 = [(0, 0, 9), (1, 2, 8), (2, 1, 5), (2, 2, 2)]
        let square1 = [(0, 1, 7), (1, 0, 9), (1, 1, 2)]
        let square2 = [(0, 0, 5), (1, 1, 6)]
        let square3 = [(1, 1, 9), (2, 1, 1)]
        let square4 = [(0, 0, 6), (0, 1, 8), (0, 2, 9), (2, 0, 7), (2, 1, 5), (2, 2, 2)]
        let square5 = [(0, 1, 2), (1, 1, 7)]
        let square6 = [(1, 1, 2), (2, 2, 7)]
        let square7 = [(1, 1, 9), (1, 2, 4), (2, 1, 6)]
        let square8 = [(0, 0, 3), (0, 1, 5), (1, 0, 6), (2, 2, 1)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        return GridFactory.convertToCoordinateValues(squares: squares)
    }
    
    // MARK: - Conversion methods

    static func convertToCoordinateValues(squares: [[ShortCoordinate]]) -> [CoordinateValue] {
        return squares.enumerated().map { squareIndex, square -> [CoordinateValue] in
            return square.map { coordinate -> CoordinateValue in
                return CoordinateValue(r: coordinate.0, c: coordinate.1, s: squareIndex, v: coordinate.2)
            }
        }.flatMap { $0 }
    }
    
    static func convertToShortCoordinates(grid: [CoordinateValue]) -> [[ShortCoordinate]] {
        var convertedGrid = [[ShortCoordinate]]()

        let sortedGrid = grid.sorted { a, b in
            a.s < b.s
        }

        for coordinateValue in sortedGrid {
            let shortCoordinate = (coordinateValue.r, coordinateValue.c, coordinateValue.v)
            
            if coordinateValue.s >= 0 && coordinateValue.s < convertedGrid.count {
                convertedGrid[coordinateValue.s].append(shortCoordinate)
            } else {
                convertedGrid.append([shortCoordinate])
            }
        }
        
        return convertedGrid
    }
    
    static func stringGridFor(grid: [CoordinateValue]) -> String {
        var stringGrid = [[Int]]()
        
        for _ in 0..<9 {
            let row = [Int](repeating: 0, count: 9)
            stringGrid.append(row)
        }
        
        for coordinate in grid {
            var adjustedRowIndex = coordinate.r
            var adjustedColIndex = coordinate.c
            
            if [3, 4, 5].contains(coordinate.s) {
                adjustedRowIndex += 3
            } else if [6, 7, 8].contains(coordinate.s) {
                adjustedRowIndex += 6
            }
            
            if [1, 4, 7].contains(coordinate.s) {
                adjustedColIndex += 3
            } else if [2, 5, 8].contains(coordinate.s) {
                adjustedColIndex += 6
            }
            
            stringGrid[adjustedRowIndex][adjustedColIndex] = coordinate.v
        }
        
        return String(describing: stringGrid)
    }
}
