//
//  SavedGameState.swift
//  Sudoku
//
//  Created by Ray Kim on 7/3/24.
//  Copyright © 2024 Self. All rights reserved.
//

import Foundation

struct SavedGameState: Codable {
    
    static let persistenceKey = "savedGameState"
    
    let workingGrid: [CoordinateValue]
    let userAction: UserAction.ActionType?
    let selectedCell: Coordinate?
    let isEditing: Bool
    let editValues: [CoordinateEditValues]
    let difficulty: Difficulty.Level

}
