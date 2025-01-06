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
    
    var title: String {
        switch self {
        case .completedCorrectly:
            return "Congratulations!"
        case .completedIncorrectly:
            return "Almost!"
        case .hintSuccess(_):
            return "Hint"
        case .hintError, .hintErrorQuota:
            return "Hint"
        case .newGame:
            return "Are you sure?"
        case .overwriteWarning:
            return "Heads up!"
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
