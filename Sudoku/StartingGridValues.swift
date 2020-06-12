//
//  StartingGridValues.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/11/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import Combine

final class StartingGridValues: ObservableObject {
    @Published
    private(set) var grid: [CoordinateValue]

    init(grid: [CoordinateValue]) {
        self.grid = grid
    }

    func values(in squareIndex: Int) -> [CoordinateValue] {
        grid.filter { _, _, s, _ -> Bool in
            s == squareIndex
        }
    }

    func reset(newGrid: [CoordinateValue]) {
        grid = newGrid
    }

    /// Checks the 3x3 square for duplicates
    func square(_ squareIndex: Int, contains value: Int) -> Bool {
        let squareValues = values(in: squareIndex)
        return squareValues.contains { _, _, _, v -> Bool in
            return v == value
        }
    }

    /// Checks the full row of the grid for duplicates
    func fullRow(for coordinate: Coordinate, contains value: Int) -> Bool {
        var rowCoordinates = [CoordinateValue]()

        if (0...2).contains(coordinate.s) {
            rowCoordinates = grid.filter { r, _, s, _ -> Bool in
                return r == coordinate.r && (0...2).contains(s)
            }
        } else if (3...5).contains(coordinate.s) {
            rowCoordinates = grid.filter { r, _, s, _ -> Bool in
                return r == coordinate.r && (3...5).contains(s)
            }
        } else if (6...8).contains(coordinate.s) {
            rowCoordinates = grid.filter { r, _, s, _ -> Bool in
                return r == coordinate.r && (6...8).contains(s)
            }
        }

        var containsValueInRow = false
        for coordinate in rowCoordinates {
            if coordinate.v == value {
                containsValueInRow = true
                break
            }
        }
        return containsValueInRow
    }

    /// Checks the full column of the grid for duplicates
    func fullColumn(for coordinate: Coordinate, contains value: Int) -> Bool {
        var colCoordinates = [CoordinateValue]()

        if [0, 3, 6].contains(coordinate.s) {
            colCoordinates = grid.filter { _, c, s, _ -> Bool in
                return c == coordinate.c && [0, 3, 6].contains(s)
            }
        } else if [1, 4, 7].contains(coordinate.s) {
            colCoordinates = grid.filter { _, c, s, _ -> Bool in
                return c == coordinate.c && [1, 4, 7].contains(s)
            }
        } else if [2, 5, 8].contains(coordinate.s) {
            colCoordinates = grid.filter { _, c, s, _ -> Bool in
                return c == coordinate.c && [2, 5, 8].contains(s)
            }
        }

        var containsValueInCol = false
        for coordinate in colCoordinates {
            if coordinate.v == value {
                containsValueInCol = true
                break
            }
        }
        return containsValueInCol
    }

    func containsAValue(at coordinate: Coordinate) -> Bool {
        let result = grid.contains { r, c, s, _ -> Bool in
            let gridCoordinate = (r: r, c: c, s: s)
            return gridCoordinate == coordinate
        }
        return result
    }

    private func contains(_ coordinateValue: CoordinateValue) -> Bool {
        let squareValues = values(in: coordinateValue.s)
        return squareValues.first { coordinateVal -> Bool in
            coordinateVal == coordinateValue
        } != nil
    }
}
