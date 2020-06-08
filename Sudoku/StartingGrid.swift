//
//  StartingGrid.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/7/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import Combine

final class StartingGrid: ObservableObject {
    @Published
    var grid: [CoordinateValue] = []

    func values(in squareIndex: Int) -> [CoordinateValue] {
        grid.filter { _, _, s, _ -> Bool in
            s == squareIndex
        }
    }
}


