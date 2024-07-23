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
        if isIpad {
            return isImage ? 20.5 : 24
        } else {
            return 10
        }
    }

    var buttonHorizontalPadding: CGFloat {
        isIpad ? 38 : 16
    }

    func body(content: Content) -> some View {
        if isVision {
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
                .cornerRadius(8)
        }
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
