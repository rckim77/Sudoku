//
//  WindowSize.swift
//  Sudoku
//
//  Created by Ray Kim on 7/14/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

@Observable final class WindowSize {
    var size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
}
