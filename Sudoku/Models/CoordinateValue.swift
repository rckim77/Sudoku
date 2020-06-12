//
//  CoordinateValue.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/12/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct CoordinateValue: Hashable {
    let r: Int
    let c: Int
    let s: Int
    let v: Int
}

typealias Coordinate = (r: Int, c: Int, s: Int)