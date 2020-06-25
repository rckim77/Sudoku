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

    func containsAValue(at coordinate: Coordinate) -> Bool {
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }
        return result
    }
}
