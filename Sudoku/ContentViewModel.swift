//
//  ContentViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ContentViewModel {
    @Environment(\.horizontalSizeClass)
    var horizontalClass

    var verticalSpacing: CGFloat {
        guard !isIpad else {
            return 50
        }

        if screenHeight > 736 { // taller than 8 Plus
            return 48
        } else if screenHeight > 667 { // 8 Plus
            return 26
        } else { // 8, SE (2nd gen)
            return 20
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

    var gridHorizontalPadding: CGFloat {
        if isLargestIpad {
            return 175
        } else {
            return horizontalSizeClassPadding
        }
    }

    var horizontalSizeClassPadding: CGFloat {
        return horizontalClass == .regular ? 80 : 0
    }
    
    // MARK: - Helper vars

    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// E.g., 12.9-inch iPads
    private var isLargestIpad: Bool {
        isIpad && screenWidth > 1023
    }

    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}
