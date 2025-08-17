//
//  StatsViewTests.swift
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
struct StatsViewTests {

    @Test(arguments: SnapshotTestHelper.devices)
    func testStatsViewSnapshots(device: Device) async throws {
        guard let size = device.1.size else {
            return assertionFailure("missing size in SnapshotTesting")
        }
        let view = StatsView()
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(size: size), named: "\(device.0)Size")
    }
}
