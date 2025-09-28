//
//  AlertItem.swift
//  Sudoku
//
//  Created by Ray Kim on 7/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

enum AlertItem: Equatable {
    case completedCorrectly
    case completedIncorrectly
    case hintSuccess(hint: String)
    case hintError
    case hintErrorQuota
    case newGame
    case overwriteWarning
    
    var localizedTitle: String {
        switch self {
        case .completedCorrectly:
            return "alert.title.completed-correctly"
        case .completedIncorrectly:
            return "alert.title.completed-incorrectly"
        case .hintSuccess(_), .hintError, .hintErrorQuota:
            return "alert.title.hint"
        case .newGame:
            return "alert.title.new-game"
        case .overwriteWarning:
            return "alert.title.overwrite-warning"
        }
    }
    
    var message: String {
        switch self {
        case .completedCorrectly:
            return "You've completed the sudoku!"
        case .completedIncorrectly:
            return "Sorry but that's not quite right. Try and use the hint feature to help you."
        case .hintSuccess(let hint):
            return hint
        case .hintError:
            return "Oops! Something went wrong. Try again later."
        case .hintErrorQuota:
            return "Quota exceeded. Please try again later."
        case .newGame:
            return "If you go back without saving, you will lose your current progress."
        case .overwriteWarning:
            return "Looks like you already have a saved game. Do you want to overwrite with this game?"
        }
    }
}
