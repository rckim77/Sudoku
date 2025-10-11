//
//  DynamicButtonStyle.swift
//  Sudoku
//
//  Created by Ray Kim on 7/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct DynamicButtonStyle: ViewModifier {
    
    let textColor: Color?
    let backgroundColor: Color?
    let isImage: Bool
    let isCompact: Bool
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var buttonVerticalPadding: CGFloat {
        if isIpad {
            if isImage {
                return 20.5
            } else if isCompact {
                return 10
            } else {
                return 24
            }
        } else {
            return 10
        }
    }

    var buttonHorizontalPadding: CGFloat {
        horizontalSizeClass == .compact ? 16 : 38
    }

    func body(content: Content) -> some View {
        if isVision { // Note: visionOS adds its own padding
            content
                .foregroundColor(textColor)
                .background(backgroundColor)
                .clipShape(Capsule())
        } else {
            content
                .foregroundColor(textColor)
                .padding(.vertical, buttonVerticalPadding)
                .padding(.horizontal, buttonHorizontalPadding)
                .background(backgroundColor)
                .cornerRadius(16)
        }
    }
}

extension View {
    func dynamicButtonStyle(textColor: Color? = nil, backgroundColor: Color? = nil, isCompact: Bool = false) -> some View {
        self.modifier(DynamicButtonStyle(textColor: textColor, backgroundColor: backgroundColor, isImage: false, isCompact: isCompact))
    }
    
    func dynamicButtonImageStyle(textColor: Color? = nil, backgroundColor: Color? = nil) -> some View {
        self.modifier(DynamicButtonStyle(textColor: textColor, backgroundColor: backgroundColor, isImage: true, isCompact: false))
    }
}
