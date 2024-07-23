//
//  AnyShape.swift
//  Sudoku
//
//  Created by Ray Kim on 7/15/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct AnyShape: Shape {
    
    private let path: (CGRect) -> Path

    init<S: Shape>(_ wrapped: S) {
        self.path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }
    
    func path(in rect: CGRect) -> Path {
        path(rect)
    }
}

extension AnyShape: @unchecked Sendable {}
