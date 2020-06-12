//
//  SelectedCell.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/3/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import Combine

final class SelectedCell: ObservableObject {
    @Published
    var coordinate: Coordinate?
}

typealias Coordinate = (r: Int, c: Int, s: Int)
