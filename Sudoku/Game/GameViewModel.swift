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
    
    var verticalSpacing: CGFloat {
        isIphone ? 16 : 4
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

    func getBottomVerticalSpacing(_ geometryHeight: CGFloat) -> CGFloat {
        if geometryHeight < GameView.lowerThreshold {
            return 12
        } else {
            return 32
        }
    }
    
    /// For the sudoku grid to render properly, both window height and width matter.
    /// Reduce the spacer height if the window height is constrained.
    func getSpacerMaxHeight(_ geometryHeight: CGFloat) -> CGFloat {
        if isIphone {
            return 16
        } else {
            let upperThreshold: CGFloat = 840 // have extra height

            if geometryHeight > upperThreshold {
                return 60
            } else if geometryHeight < GameView.lowerThreshold {
                return 2
            } else {
                return 8
            }
        }
    }
}
