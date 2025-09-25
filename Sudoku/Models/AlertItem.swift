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
            return String(localized: "alert_congratulations")
        case .completedIncorrectly:
            return String(localized: "alert_almost")
        case .hintSuccess(_):
            return String(localized: "alert_hint_title")
        case .hintError, .hintErrorQuota:
            return String(localized: "alert_hint_title")
        case .newGame:
            return String(localized: "alert_confirm_title")
        case .overwriteWarning:
            return String(localized: "alert_heads_up")
        }
    }
    
    var message: String {
        switch self {
        case .completedCorrectly:
            return String(localized: "alert_completed_correctly")
        case .completedIncorrectly:
            return String(localized: "alert_completed_incorrectly")
        case .hintSuccess(let hint):
            return hint
        case .hintError:
            return String(localized: "alert_hint_error")
        case .hintErrorQuota:
            return String(localized: "alert_hint_quota")
        case .newGame:
            return String(localized: "alert_new_game_message")
        case .overwriteWarning:
            return String(localized: "alert_overwrite_warning")
        }
    }
}
