//
//  GridValues.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/7/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import Combine

final class GridValues: ObservableObject {
    @Published
    private(set) var grid: [CoordinateValue]

    var isSolved: Bool {
        return SudokuSolver.gridIsSolved(self)
    }

    init(grid: [CoordinateValue]) {
        self.grid = grid
    }

    func values(in squareIndex: Int) -> [CoordinateValue] {
        grid.filter { coordinateValue -> Bool in
            coordinateValue.s == squareIndex
        }
    }

    func add(_ coordinateValue: CoordinateValue) {
        let coordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
        removeValue(at: coordinate)
        grid.append(coordinateValue)
    }

    func removeValue(at coordinate: Coordinate) {
        grid.removeAll { coordinateValue -> Bool in
            coordinateValue.r == coordinate.r && coordinateValue.c == coordinate.c && coordinateValue.s == coordinate.s
        }
    }

    func containsAValue(at coordinate: Coordinate) -> Bool {
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }
        return result
    }

    func contains(value: Int, at coordinate: Coordinate) -> Bool {
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate && coordinateValue.v == value
        }
        return result
    }

    func retrieveValue(at coordinate: Coordinate) -> Int? {
        let squareValues = values(in: coordinate.s)
        return squareValues.filter({ coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }).first?.v
    }

    // MARK: - Private methods

    private func contains(_ coordinateValue: CoordinateValue) -> Bool {
        let squareValues = values(in: coordinateValue.s)
        return squareValues.first { coordinateVal -> Bool in
            coordinateVal == coordinateValue
        } != nil
    }
}


