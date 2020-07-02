//
//  EditGridValues.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

final class EditGridValues: ObservableObject {
    /// Note: Only includes coordinates that contain more than 0 edited values.
    @Published
    var grid: [CoordinateEditValues]

    init(grid: [CoordinateEditValues]) {
        self.grid = grid
    }
    
    var isEmpty: Bool {
        grid.isEmpty
    }

    // Note: this returns a copy because grid is an array of value types.
    func guesses(for coordinate: Coordinate) -> CoordinateEditValues? {
        return grid.first(where: { $0.r == coordinate.r && $0.c == coordinate.c && $0.s == coordinate.s })
    }

    func updateGuesses(value: Int, at coordinate: Coordinate) {
        if let existingEditGrid = guesses(for: coordinate) {
            var set = existingEditGrid.values

            if set.contains(value) {
                set.remove(value)
            } else {
                set.insert(value)
            }
            
            grid.removeAll(where: { $0.c == coordinate.c && $0.r == coordinate.r && $0.s == coordinate.s })
            let editValues = CoordinateEditValues(r: coordinate.r, c: coordinate.c, s: coordinate.s, values: set)
            grid.append(editValues)
        } else {
            var values = Set<Int>()
            values.insert(value)
            let editValues = CoordinateEditValues(r: coordinate.r, c: coordinate.c, s: coordinate.s, values: values)
            grid.append(editValues)
        }
    }

    func removeValues(at coordinate: Coordinate) {
        grid.removeAll(where: { $0.r == coordinate.r && $0.c == coordinate.c && $0.s == coordinate.s })
    }
}
