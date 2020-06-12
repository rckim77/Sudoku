//
//  AbsoluteCoordinateValue.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/12/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct AbsoluteCoordinateValue: Hashable {
    /// Row index irrespective of what square index it is in (i.e., ranges from 0 to 8)
    let r: Int
    /// Column index irrespective of what square index it is in (i.e., ranges from 0 to 8)
    let c: Int
    let v: Int
}
