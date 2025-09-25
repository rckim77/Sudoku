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
    @State private var isLaunchScreenVisible = true

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                if isLaunchScreenVisible {
                    LaunchScreenView()
                        .onAppear {
                            // Show launch screen for a brief moment, then transition to main app
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isLaunchScreenVisible = false
                                }
                            }
                        }
                } else {
                    MenuView()
                        .environment(WindowSize(size: geometry.size))
                        .transition(.opacity)
                }
            }
        }
        .modelContainer(for: GameConfig.self)
    }
}
