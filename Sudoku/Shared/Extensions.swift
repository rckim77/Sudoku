//
//  Extensions.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }

    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    /// E.g., 12.9-inch iPads
    var isLargestIpad: Bool {
        isIpad && screenWidth > 1023
    }

    var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}

extension ViewModifier {
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    /// E.g., 12.9-inch iPads
    var isLargestIpad: Bool {
        isIpad && screenWidth > 1023
    }
}
