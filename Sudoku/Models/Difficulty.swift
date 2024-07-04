//
//  Difficulty.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

final class Difficulty: ObservableObject {

    enum Level: String, Codable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
    }

    @Published
    var level: Level

    init(level: Level) {
        self.level = level
    }
}
