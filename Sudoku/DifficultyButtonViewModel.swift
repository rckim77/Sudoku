//
//  DifficultyButtonViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct DifficultyButtonViewModel: ViewModel {

    let level: Difficulty.Level
    let editGridIsEmpty: Bool
    let workingGridHasMoreValues: Bool
    
    var buttonVerticalPadding: CGFloat {
        if isLargestIpad {
            return 24
        } else if isIpad {
            return 20
        } else {
            return 10
        }
    }

    var buttonHorizontalPadding: CGFloat {
        if isLargestIpad {
            return 38
        } else if isIpad {
            return 32
        } else {
            return 16
        }
    }

    var shouldDisplayAlert: Bool {
        workingGridHasMoreValues || !editGridIsEmpty
    }
}
