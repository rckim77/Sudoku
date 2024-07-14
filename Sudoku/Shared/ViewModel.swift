//
//  ViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

protocol ViewModel {
    var isIpad: Bool { get }
    var isVision: Bool { get }
    var isLargestIpad: Bool { get }
    var screenHeight: CGFloat { get }
    var screenWidth: CGFloat { get }
}

extension ViewModel {
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var isVision: Bool {
        UIDevice.current.userInterfaceIdiom == .vision
    }

    /// E.g., 12.9-inch iPads
    var isLargestIpad: Bool {
        guard !isVision else {
            return false
        }

        return isIpad && screenWidth > 1023
    }

    var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}
