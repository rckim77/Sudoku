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

    var isFull: Bool {
        grid.count == 81
    }

    init(grid: [CoordinateValue]) {
        self.grid = grid
    }

    func values(in squareIndex: Int) -> [CoordinateValue] {
        grid.filter { _, _, s, _ -> Bool in
            s == squareIndex
        }
    }

    func add(_ coordinateValue: CoordinateValue) {
        let coordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
        removeValue(at: coordinate)
        grid.append(coordinateValue)
    }

    func removeValue(at coordinate: Coordinate) {
        grid.removeAll { r, c, s, v -> Bool in
            r == coordinate.r && c == coordinate.c && s == coordinate.s
        }
    }

    func containsAValue(at coordinate: Coordinate) -> Bool {
        let result = grid.contains { r, c, s, _ -> Bool in
            let gridCoordinate = (r: r, c: c, s: s)
            return gridCoordinate == coordinate
        }
        return result
    }

    func contains(value: Int, at coordinate: Coordinate) -> Bool {
        let result = grid.contains { r, c, s, v -> Bool in
            let gridCoordinate = (r: r, c: c, s: s)
            return gridCoordinate == coordinate && v == value
        }
        return result
    }

    func retrieveValue(at coordinate: Coordinate) -> Int? {
        let squareValues = values(in: coordinate.s)
        return squareValues.filter({ r, c, s, v -> Bool in
                    let gridCoordinate = (r: r, c: c, s: s)
                    return gridCoordinate == coordinate
                }).first?.v
    }

    private func contains(_ coordinateValue: CoordinateValue) -> Bool {
        let squareValues = values(in: coordinateValue.s)
        return squareValues.first { coordinateVal -> Bool in
            coordinateVal == coordinateValue
        } != nil
    }
}


