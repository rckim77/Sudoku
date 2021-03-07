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

    var buttonVerticalPadding: CGFloat {
        if isLargestIpad {
            return isImage ? 20.5 : 24
        } else if isIpad {
            return isImage ? 16.5 : 20
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
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .padding(.vertical, buttonVerticalPadding)
            .padding(.horizontal, buttonHorizontalPadding)
            .background(backgroundColor)
            .cornerRadius(8)
    }
}

extension View {
    func dynamicButtonStyle(textColor: Color? = nil, backgroundColor: Color? = nil) -> some View {
        self.modifier(DynamicButtonStyle(textColor: textColor, backgroundColor: backgroundColor, isImage: false))
    }
    
    func dynamicButtonImageStyle(textColor: Color? = nil, backgroundColor: Color? = nil) -> some View {
        self.modifier(DynamicButtonStyle(textColor: textColor, backgroundColor: backgroundColor, isImage: true))
    }
}
