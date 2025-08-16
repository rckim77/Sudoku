//
//  SnapshotTests.swift
//  SudokuTests
//
//  Created by Ray Kim on 8/16/25.
//  Copyright © 2025 Self. All rights reserved.
//

@testable import Sudoku

import SnapshotTesting
import Testing
import SwiftUI

/*
 
Note: The devices will have to be updated over time as we drop iOS support for
 certain devices and the SnapshotTesting Swift package gets updated with newer
 screen sizes.
 
.iPhone13 size is equivalent to iPhone 13 Pro, 14, 12 Pro, and 12
.iPhone13ProMax size is equivalent to iPhone 12 Pro Max and 14 Plus
.iPhone13Mini size is equivalent to iPhone 12 mini

*/
@MainActor
struct SnapshotTests {
    
    private let devices: [(String, ViewImageConfig)] = [("iPhone13Mini", .iPhone13Mini),
                                                        ("iPhone13", .iPhone13),
                                                        ("iPhone13ProMax", .iPhone13ProMax)]

    @Test func testMenuViewSnapshots() async throws {
        for (name, device) in devices {
            let view = MenuView()
            let vc = UIHostingController(rootView: view)
            assertSnapshot(of: vc, as: .image(on: device), named: "\(name)Size")
        }
    }
    
    @Test func testHowToPlayViewSnapshots() async throws {
        for (name, device) in devices {
            guard let size = device.size else {
                return assertionFailure("missing size in SnapshotTesting")
            }
            let view = HowToPlayView().environment(WindowSize(size: size))
            let vc = UIHostingController(rootView: view)
            assertSnapshot(of: vc, as: .image(on: device), named: "\(name)Size")
        }
    }
    
    @Test func testGameViewSnapshots() async throws {
        for (name, device) in devices {
            guard let size = device.size else {
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
            assertSnapshot(of: vc, as: .image(on: device), named: "\(name)Size")
        }
    }
}
