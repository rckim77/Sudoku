//
//  SelectedCell.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/3/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

final class SelectedCell: ObservableObject {
    @Published
    var coordinate: Coordinate?
}
