//
//  CoordinateColor.swift
//  Sudoku
//
//  Created by Ray Kim on 6/29/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct CoordinateColor: Hashable {
    let coordinate: CoordinateValue
    let color: Color
    
    var s: Int {
        coordinate.s
    }
    
    var r: Int {
        coordinate.r
    }
    
    var c: Int {
        coordinate.c
    }
}
