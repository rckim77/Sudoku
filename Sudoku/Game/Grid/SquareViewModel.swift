//
//  SquareViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 7/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct SquareViewModel: ViewModel {

    let rowIndices = [0, 1, 2]
    var borderWidth: CGFloat {
        screenHeight > 667 ? 3 : 2
    }
}
