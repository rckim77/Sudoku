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
    }

    var level: Level

    init(level: Level) {
        self.level = level
    }
}
