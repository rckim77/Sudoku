//
//  DifficultyButtonViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct DifficultyButtonViewModel {

    let level: Difficulty.Level
    let editGridIsEmpty: Bool
    let workingGridHasMoreValues: Bool

    var shouldDisplayAlert: Bool {
        workingGridHasMoreValues || !editGridIsEmpty
    }
}
