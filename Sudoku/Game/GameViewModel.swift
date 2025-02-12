//
//  GameViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct GameViewModel: ViewModel {
    
    let difficulty: Difficulty.Level

    let bottomVerticalSpacing: CGFloat = 32

    var verticalSpacing: CGFloat {
        isVision ? 8 : 16
    }
    
    var timerHorizontalOffset: CGFloat {
        isIpad ? 140 : 100
    }

    var toolbarItemPlacement: ToolbarItemPlacement {
        #if os(visionOS)
        return .bottomOrnament
        #else
        return .bottomBar
        #endif
    }
    
    let toolbarItemHorizontalSpacing: CGFloat = 24
    
    var toolbarBottomPadding: CGFloat {
        if isIpad {
            return 32
        } else if isVision {
            return 0
        } else {
            return 16
        }
    }
    
    func getSpacerMaxHeight(_ geometryHeight: CGFloat) -> CGFloat {
        let verticalThreshold: CGFloat = 900

        if isVision {
            return 8
        } else if geometryHeight > verticalThreshold {
            return 60
        } else {
            return 16
        }
    }
}
