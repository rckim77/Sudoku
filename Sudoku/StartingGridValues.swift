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
        grid.filter { coordinateValue -> Bool in
            coordinateValue.s == squareIndex
        }
    }

    func reset(newGrid: [CoordinateValue]) {
        grid = newGrid
    }

    /// Checks the 3x3 square for duplicates
    func square(_ squareIndex: Int, contains value: Int) -> Bool {
        let squareValues = values(in: squareIndex)
        return squareValues.contains { coordinateValue -> Bool in
            return coordinateValue.v == value
        }
    }

    /// Checks the full row of the grid for duplicates
    func fullRow(for coordinate: Coordinate, contains value: Int) -> Bool {
        var rowCoordinates = [CoordinateValue]()

        if (0...2).contains(coordinate.s) {
            rowCoordinates = grid.filter { coordinateValue -> Bool in
                return coordinateValue.r == coordinate.r && (0...2).contains(coordinateValue.s)
            }
        } else if (3...5).contains(coordinate.s) {
            rowCoordinates = grid.filter { coordinateValue -> Bool in
                return coordinateValue.r == coordinate.r && (3...5).contains(coordinateValue.s)
            }
        } else if (6...8).contains(coordinate.s) {
            rowCoordinates = grid.filter { coordinateValue -> Bool in
                return coordinateValue.r == coordinate.r && (6...8).contains(coordinateValue.s)
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
            colCoordinates = grid.filter { coordinateValue -> Bool in
                return coordinateValue.c == coordinate.c && [0, 3, 6].contains(coordinateValue.s)
            }
        } else if [1, 4, 7].contains(coordinate.s) {
            colCoordinates = grid.filter { coordinateValue -> Bool in
                return coordinateValue.c == coordinate.c && [1, 4, 7].contains(coordinateValue.s)
            }
        } else if [2, 5, 8].contains(coordinate.s) {
            colCoordinates = grid.filter { coordinateValue -> Bool in
                return coordinateValue.c == coordinate.c && [2, 5, 8].contains(coordinateValue.s)
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
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
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
