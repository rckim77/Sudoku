//
//  GameViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct GameViewModel: ViewModel {
    @Environment(\.horizontalSizeClass)
    var horizontalClass
    
    let difficulty: Difficulty.Level

    var verticalSpacing: CGFloat {
        guard !isIpad else {
            return 40
        }

        if screenHeight > 736 { // taller than 8 Plus
            return 46
        } else if screenHeight > 667 { // 8 Plus
            return 24
        } else { // 8, SE (2nd gen)
            return 18
        }
    }

    var clearButtonHorizontalPadding: CGFloat {
        if screenHeight > 736 { // taller than 8 Plus
            return 22
        } else { // 8 Plus, 8, SE (2nd gen)
            return 14
        }
    }

    var clearButtonVerticalPadding: CGFloat {
        if screenHeight > 736 { // taller than 8 Plus
            return 10
        } else { // 8 Plus, 8, SE (2nd gen)
            return 8
        }
    }

    var modifierButtonsHorizontalSpacing: CGFloat {
        isIpad ? 36 : 12
    }

    var horizontalSizeClassPadding: CGFloat {
        return horizontalClass == .regular ? 80 : 0
    }
}
