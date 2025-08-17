//
//  GameViewTests.swift
//  SudokuTests
//
//  Created by Ray Kim on 8/16/25.
//  Copyright © 2025 Self. All rights reserved.
//

@testable import Sudoku

import SnapshotTesting
import Testing
import SwiftUI

@MainActor
struct GameViewTests {

    @Test(arguments: SnapshotTestHelper.devices)
    func testGameViewSnapshots(device: Device) async throws {
        guard let size = device.1.size else {
            return assertionFailure("missing size in SnapshotTesting")
        }
        let startingGrid = GridFactory.easyGrid
        let gameConfig = GameConfig(savedState: .startedUnsaved,
                                    workingGrid: startingGrid,
                                    startingGrid: startingGrid,
                                    difficulty: .easy,
                                    elapsedTime: 0)
        let view = GameView(gameConfig).environment(WindowSize(size: size))
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(size: size), named: "\(device.0)Size")
        let darkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(of: vc, as: .image(size: size, traits: darkMode), named: "\(device.0)SizeDark")
    }
}
