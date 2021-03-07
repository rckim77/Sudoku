//
//  GridFactory.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/18/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

enum GridFactory {
    /// (row, column, square, value)
    typealias ShortCoordinate = (Int, Int, Int, Int)

    static func gridForDifficulty(level: Difficulty.Level) -> [CoordinateValue] {
        let randomNumber = Int.random(in: 0...1)
        switch level {
        case .easy:
            return randomNumber == 0 ? easyGrid : easyGrid1
        case .medium:
            return randomNumber == 0 ? mediumGrid : mediumGrid1
        case .hard:
            return randomNumber == 0 ? hardGrid : hardGrid1
        }
    }
    
    /// FOR TESTING
    static var superEasyGrid: [CoordinateValue] {
        let square0 = [(0, 0, 0, 9), (0, 1, 0, 6), (0, 2, 0, 2), (1, 0, 0, 1), (1, 1, 0, 8), (1, 2, 0, 5), (2, 0, 0, 3), (2, 1, 0, 7), (2, 2, 0, 4)]
        let square1 = [(0, 0, 1, 3), (0, 1, 1, 7), (0, 2, 1, 8), (1, 0, 1, 4), (1, 1, 1, 2), (1, 2, 1, 9), (2, 0, 1, 5), (2, 1, 1, 6), (2, 2, 1, 1)]
        let square2 = [(0, 0, 2, 4), (0, 1, 2, 1), (0, 2, 2, 5), (1, 0, 2, 7), (1, 1, 2, 6), (1, 2, 2, 3), (2, 0, 2, 9), (2, 1, 2, 2), (2, 2, 2, 8)]
        let square3 = [(0, 0, 3, 4), (0, 1, 3, 9), (0, 2, 3, 6), (1, 0, 3, 2), (1, 1, 3, 1), (1, 2, 3, 8), (2, 0, 3, 7), (2, 1, 3, 5), (2, 2, 3, 3)]
        let square4 = [(0, 0, 4, 8), (0, 1, 4, 3), (0, 2, 4, 2), (1, 0, 4, 7), (1, 2, 4, 5), (2, 1, 4, 9), (2, 2, 4, 6)]
        let square5 = [(0, 0, 5, 1), (0, 1, 5, 5), (0, 2, 5, 7), (1, 1, 5, 9), (2, 2, 5, 4)]
        let square6 = [(0, 0, 6, 5), (0, 2, 6, 1), (1, 2, 6, 7), (2, 0, 6, 6), (2, 1, 6, 4)]
        let square7 = [(0, 0, 7, 9), (0, 1, 7, 8), (0, 2, 7, 4), (1, 0, 7, 6), (1, 1, 7, 1), (1, 2, 7, 3), (2, 0, 7, 2), (2, 1, 7, 5), (2, 2, 7, 7)]
        let square8 = [(0, 0, 8, 6), (0, 1, 8, 7), (0, 2, 8, 2), (1, 0, 8, 5), (1, 1, 8, 4), (2, 1, 8, 3), (2, 2, 8, 1)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
            .map { GridFactory.convertToCoordinateValues(grid: $0) }
        return squares.flatMap { $0 }
    }

    static var easyGrid: [CoordinateValue] {
        let square0 = [(0, 0, 0, 8), (1, 1, 0, 9), (2, 0, 0, 5), (2, 1, 0, 7), (2, 2, 0, 1)]
        let square1 = [(0, 0, 1, 9), (0, 1, 1, 5), (1, 0, 1, 2), (1, 2, 1, 8), (2, 0, 1, 3), (2, 2, 1, 6)]
        let square2 = [(0, 0, 2, 4), (0, 1, 2, 6), (0, 2, 2, 1), (1, 0, 2, 5), (1, 1, 2, 3), (1, 2, 2, 7), (2, 1, 2, 9)]
        let square3 = [(0, 0, 3, 1), (1, 1, 3, 6), (1, 2, 3, 2), (2, 0, 3, 9), (2, 2, 3, 5)]
        let square4 = [(0, 0, 4, 6), (1, 0, 4, 5), (1, 2, 4, 9), (2, 1, 4, 7), (2, 2, 4, 1)]
        let square5 = [(0, 0, 5, 9), (1, 1, 5, 7), (2, 2, 5, 3)]
        let square6 = [(0, 0, 6, 2), (0, 2, 6, 8), (1, 2, 6, 4), (2, 0, 6, 7), (2, 1, 6, 3)]
        let square7 = [(0, 0, 7, 7), (0, 2, 7, 5), (1, 0, 7, 8), (1, 2, 7, 3), (2, 0, 7, 1), (2, 2, 7, 4)]
        let square8 = [(0, 0, 8, 3), (0, 2, 8, 6), (1, 1, 8, 1), (2, 1, 8, 5), (2, 2, 8, 2)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
            .map { GridFactory.convertToCoordinateValues(grid: $0) }
        return squares.flatMap { $0 }
    }
    
    static var easyGrid1: [CoordinateValue] {
        let square0 = [(0, 1, 0, 6), (1, 0, 0, 1), (1, 1, 0, 8), (1, 2, 0, 5)]
        let square1 = [(0, 0, 1, 3), (1, 1, 1, 2), (2, 0, 1, 5)]
        let square2 = [(0, 0, 2, 4), (0, 1, 2, 1), (1, 0, 2, 7), (1, 2, 2, 3), (2, 0, 2, 9), (2, 1, 2, 2), (2, 2, 2, 8)]
        let square3 = [(0, 1, 3, 9), (0, 2, 3, 6), (1, 0, 3, 2), (1, 1, 3, 1), (2, 1, 3, 5)]
        let square4 = [(0, 0, 4, 8), (0, 2, 4, 2), (1, 1, 4, 4), (2, 2, 4, 6)]
        let square5 = [(0, 1, 5, 5), (0, 2, 5, 7), (1, 0, 5, 3), (2, 1, 5, 8), (2, 2, 5, 4)]
        let square6 = [(0, 0, 6, 5), (2, 2, 6, 9)]
        let square7 = [(0, 2, 7, 4), (1, 0, 7, 6), (1, 1, 7, 1), (1, 2, 7, 3), (2, 2, 7, 7)]
        let square8 = [(0, 0, 8, 6), (1, 0, 8, 5), (1, 1, 8, 4)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
            .map { GridFactory.convertToCoordinateValues(grid: $0) }
        return squares.flatMap { $0 }
    }

    static var mediumGrid: [CoordinateValue] {
        let square0 = [(0, 0, 0, 1), (0, 2, 0, 2), (1, 0, 0, 3), (1, 1, 0, 9)]
        let square1 = [(0, 0, 1, 8), (2, 1, 1, 1)]
        let square2 = [(0, 2, 2, 6), (1, 0, 2, 8), (2, 2, 2, 3)]
        let square3 = [(0, 2, 3, 7), (1, 1, 3, 6)]
        let square4 = [(0, 0, 4, 1), (0, 2, 4, 3), (1, 0, 4, 2), (1, 1, 4, 7), (1, 2, 4, 4), (2, 0, 4, 6), (2, 2, 4, 5)]
        let square5 = [(1, 1, 5, 5), (2, 0, 5, 1)]
        let square6 = [(0, 0, 6, 6), (1, 2, 6, 5), (2, 0, 6, 4)]
        let square7 = [(0, 1, 7, 4), (2, 2, 7, 1)]
        let square8 = [(1, 1, 8, 2), (1, 2, 8, 1), (2, 0, 8, 6), (2, 2, 8, 7)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
            .map { GridFactory.convertToCoordinateValues(grid: $0) }
        return squares.flatMap { $0 }
    }
    
    static var mediumGrid1: [CoordinateValue] {
        let square0 = [(0, 2, 0, 4), (1, 0, 0, 7), (1, 2, 0, 2), (2, 0, 0, 8)]
        let square1 = [(0, 1, 1, 7), (1, 0, 1, 9), (1, 1, 1, 4), (1, 2, 1, 3), (2, 2, 1, 2)]
        let square2 = [(0, 0, 2, 2), (0, 2, 2, 6)]
        let square3 = [(1, 1, 3, 2), (2, 1, 3, 9)]
        let square4 = [(1, 2, 4, 5), (2, 1, 4, 3)]
        let square5 = [(1, 0, 5, 3), (2, 1, 5, 6), (2, 2, 5, 5)]
        let square6 = [(0, 0, 6, 9), (0, 2, 6, 1), (1, 2, 6, 8)]
        let square7 = [(0, 0, 7, 7), (0, 1, 7, 2), (0, 2, 7, 4), (1, 0, 7, 5), (1, 2, 7, 9)]
        let square8 = [(0, 0, 8, 6), (0, 1, 8, 5), (1, 0, 8, 4), (1, 2, 8, 2)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
            .map { GridFactory.convertToCoordinateValues(grid: $0) }
        return squares.flatMap { $0 }
    }

    static var hardGrid: [CoordinateValue] {
        let square0 = [(0, 1, 0, 1), (1, 0, 0, 5), (1, 2, 0, 3), (2, 0, 0, 4)]
        let square1 = [(2, 0, 1, 7), (2, 1, 1, 1)]
        let square2 = [(0, 1, 2, 3), (1, 2, 2, 8), (2, 2, 2, 9)]
        let square3 = [(0, 1, 3, 9), (1, 2, 3, 6)]
        let square4 = [(0, 0, 4, 6), (1, 0, 4, 5), (1, 2, 4, 2), (2, 2, 4, 9)]
        let square5 = [(1, 0, 5, 9), (2, 1, 5, 8)]
        let square6 = [(0, 0, 6, 7), (1, 0, 6, 1), (2, 1, 6, 6)]
        let square7 = [(0, 1, 7, 4), (0, 2, 7, 5)]
        let square8 = [(0, 2, 8, 1), (1, 0, 8, 3), (1, 2, 8, 2), (2, 1, 8, 5)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
            .map { GridFactory.convertToCoordinateValues(grid: $0) }
        return squares.flatMap { $0 }
    }
    
    static var hardGrid1: [CoordinateValue] {
        let square0 = [(0, 2, 0, 1), (1, 1, 0, 9), (2, 1, 0, 8)]
        let square1 = [(0, 1, 1, 4), (0, 2, 1, 6), (1, 2, 1, 8), (2, 0, 1, 5)]
        let square2 = [(0, 2, 2, 2)]
        let square3 = [(1, 0, 3, 1), (1, 1, 3, 3), (1, 2, 3, 8), (2, 1, 3, 7), (2, 2, 3, 6)]
        let square4 = [(0, 0, 4, 2), (2, 0, 4, 3)]
        let square5 = [(1, 1, 5, 5)]
        let square6 = [(0, 1, 6, 1), (1, 0, 6, 3)]
        let square7 = [(0, 1, 7, 9), (1, 2, 7, 5)]
        let square8 = [(0, 2, 8, 8), (1, 0, 8, 4), (1, 1, 8, 2), (2, 1, 8, 6), (2, 2, 8, 1)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
            .map { GridFactory.convertToCoordinateValues(grid: $0) }
        return squares.flatMap { $0 }
    }

    static func convertToCoordinateValues(grid: [ShortCoordinate]) -> [CoordinateValue] {
        return grid.map { CoordinateValue(r: $0.0, c: $0.1, s: $0.2, v: $0.3) }
    }
}
