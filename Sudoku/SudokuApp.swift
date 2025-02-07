//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Ray Kim on 1/10/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct SudokuApp: App {

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                MenuView()
                    .environment(WindowSize(size: geometry.size))
            }
        }
        .modelContainer(for: GameConfig.self)
    }
}
