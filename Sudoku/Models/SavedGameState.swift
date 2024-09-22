//
//  SavedGameState.swift
//  Sudoku
//
//  Created by Ray Kim on 7/3/24.
//  Copyright © 2024 Self. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class SavedGameState {

    var workingGrid: [CoordinateValue]
    var startingGrid: [CoordinateValue]
    var colorGrid: Set<CoordinateColor>
    var userAction: UserAction.ActionType?
    var selectedCell: Coordinate?
    var isEditing: Bool
    var editValues: [CoordinateEditValues]
    var difficulty: Difficulty.Level
    
    init(workingGrid: [CoordinateValue], startingGrid: [CoordinateValue], colorGrid: Set<CoordinateColor>, userAction: UserAction.ActionType?, selectedCell: Coordinate?, isEditing: Bool, editValues: [CoordinateEditValues], difficulty: Difficulty.Level) {
        self.workingGrid = workingGrid
        self.startingGrid = startingGrid
        self.colorGrid = colorGrid
        self.userAction = userAction
        self.selectedCell = selectedCell
        self.isEditing = isEditing
        self.editValues = editValues
        self.difficulty = difficulty
    }
}
