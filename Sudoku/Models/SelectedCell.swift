//
//  SelectedCell.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/3/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

@Observable final class SelectedCell {
    var coordinate: Coordinate?
    
    init(coordinate: Coordinate? = nil) {
        self.coordinate = coordinate
    }
}
