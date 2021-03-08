//
//  AlertItem.swift
//  Sudoku
//
//  Created by Ray Kim on 7/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct AlertItem: Identifiable {
    enum AlertItemType {
        case newGame, completedCorrectly, completedIncorrectly
    }
    
    let id: AlertItemType
}
