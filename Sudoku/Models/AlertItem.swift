//
//  AlertItem.swift
//  Sudoku
//
//  Created by Ray Kim on 7/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import SwiftUI

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
    
    /// Will return either a localizable string key or the actual translated message from the API
    var message: String {
        switch self {
        case .completedCorrectly:
            return "alert.message.completed-correctly"
        case .completedIncorrectly:
            return "alert.message.completed-incorrectly"
        case .hintSuccess(let hint):
            return hint
        case .hintError:
            return "alert.message.hint-error"
        case .hintErrorQuota:
            return "alert.message.hint-error-quota"
        case .newGame:
            return "alert.message.new-game"
        case .overwriteWarning:
            return "alert.message.overwrite-warning"
        }
    }
}
