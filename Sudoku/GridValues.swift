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
    var grid: [CoordinateValue] = []

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

    func containsValue(at coordinate: Coordinate) -> Bool {
        grid.contains { r, c, s, _ -> Bool in
            let gridCoordinate = (r: r, c: c, s: s)
            return gridCoordinate == coordinate
        }
    }

    private func contains(_ coordinateValue: CoordinateValue) -> Bool {
        let squareValues = values(in: coordinateValue.s)
        return squareValues.first { coordinateVal -> Bool in
            coordinateVal == coordinateValue
        } != nil
    }
}


