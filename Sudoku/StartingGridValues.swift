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

    func containsValue(at coordinate: Coordinate) -> Bool {
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
