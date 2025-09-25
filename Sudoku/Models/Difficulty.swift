//
//  Difficulty.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

@Observable final class Difficulty {

    enum Level: String, Codable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
        
        var localizedName: String {
            switch self {
            case .easy:
                return String(localized: "difficulty_easy")
            case .medium:
                return String(localized: "difficulty_medium")
            case .hard:
                return String(localized: "difficulty_hard")
            }
        }
    }

    var level: Level

    init(level: Level) {
        self.level = level
    }
}
