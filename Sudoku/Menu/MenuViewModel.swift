//
//  MenuViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 7/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct MenuViewModel: ViewModel {
    
    var savedGameVSpacing: CGFloat {
        16 * (isIpad ? 2.5 : 1)
    }
    
    var buttonsVSpacing: CGFloat {
        40 * (isIpad ? 2 : 1)
    }
    
    let difficultyLevels: [Difficulty.Level] = [.easy, .medium, .hard]
}
