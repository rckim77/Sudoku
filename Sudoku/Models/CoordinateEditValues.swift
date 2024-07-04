//
//  CoordinateEditValues.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct CoordinateEditValues: Equatable, Codable {
    let r: Int
    let c: Int
    let s: Int
    var values: Set<Int>
}
