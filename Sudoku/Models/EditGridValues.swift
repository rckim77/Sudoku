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

    func values(for coordinate: Coordinate) -> Set<Int> {
        /// Get edit values for coordinate if they're in grid.
        guard let values = grid
            .filter({ $0.r == coordinate.r && $0.c == coordinate.c && $0.s == coordinate.s })
            .first else {
            return []
        }
        return Set(values.values)
    }
}
