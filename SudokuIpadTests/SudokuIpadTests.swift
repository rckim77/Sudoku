//
//  SudokuIpadTests.swift
//  SudokuIpadTests
//
//  Created by Ray Kim on 10/10/25.
//  Copyright © 2025 Self. All rights reserved.
//

@testable import Sudoku

import SnapshotTesting
import Testing
import SwiftUI

@Suite(.snapshots(record: .never))
@MainActor
struct SnapshotTests {

    @Test(arguments: SnapshotTestHelper.ipads)
    func testGameViewSnapshot(_ device: Device) async throws {
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
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true), named: "\(device.0)")
        let darkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true, traits: darkMode), named: "\(device.0)Dark")
    }
    
    @Test(arguments: SnapshotTestHelper.ipads)
    func testHowToPlayViewSnapshot(_ device: Device) async throws {
        guard let size = device.1.size else {
            return assertionFailure("missing size in SnapshotTesting")
        }
        let view = HowToPlayView().environment(WindowSize(size: size))
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true), named: "\(device.0)")
        let darkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true, traits: darkMode), named: "\(device.0)Dark")
    }
    
    @Test(arguments: SnapshotTestHelper.ipads)
    func testMenuViewSnapshot(_ device: Device) async throws {
        let view = MenuView()
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true), named: "\(device.0)")
        let darkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true, traits: darkMode), named: "\(device.0)Dark")
    }
    
    @Test(arguments: SnapshotTestHelper.ipads)
    func testStatsViewSnapshot(_ device: Device) async throws {
        let view = StatsView()
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true), named: "\(device.0)")
        let darkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(of: vc, as: .image(on: device.1, drawHierarchyInKeyWindow: true, traits: darkMode), named: "\(device.0)Dark")
    }
}
