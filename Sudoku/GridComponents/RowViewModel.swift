//
//  RowViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/24/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct RowViewModel {
    let index: Int
    let columns: [Int]
    let squareIndex: Int
    let selectedColumnIndex: Int?
    
    private let backgroundColor = Color("dynamicGridWhite")
    private let selectedBackgroundColor = Color("dynamicGridSelection")
    
    func backgroundColorFor(_ columnIndex: Int) -> Color {
        return selectedColumnIndex == columnIndex ? selectedBackgroundColor : backgroundColor
    }
}
