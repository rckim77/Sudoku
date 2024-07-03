//
//  CoordinateValue.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/12/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct CoordinateValue: Hashable, Codable {
    let r: Int
    let c: Int
    let s: Int
    let v: Int
    
    var coordinate: Coordinate {
        return Coordinate(r: r, c: c, s: s)
    }
}

struct Coordinate: Equatable, Codable {
    let r: Int
    let c: Int
    let s: Int
}
