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
    
    func getSpacerMaxHeight(_ geometrySize: CGSize) -> CGFloat {
        let verticalThreshold: CGFloat = 900
        let isLandscape = geometrySize.width > geometrySize.height

        if isVision {
            return 8
        } else if isLandscape && isIpad {
            // In landscape mode on iPad, minimize spacer to save vertical space
            return 8
        } else if geometrySize.height > verticalThreshold {
            return 60
        } else {
            return 16
        }
    }
    
    func getMaxGridHeight(_ geometrySize: CGSize) -> CGFloat? {
        let isLandscape = geometrySize.width > geometrySize.height
        
        if isLandscape && isIpad {
            // In landscape mode on iPad, constrain grid height to fit available space
            // Reserve space for: KeysRow (72pt + spacing), toolbar (~50pt), 
            // timer/buttons (~50pt), spacers (~60pt), safe areas (~20pt)
            let reservedSpace: CGFloat = 252
            let maxGridHeight = geometrySize.height - reservedSpace
            // Grid should fill most of available space (minimum 300pt for small windows)
            return max(maxGridHeight, 300)
        } else {
            // In portrait mode or on other devices, let the grid size naturally
            return nil
        }
    }
}
