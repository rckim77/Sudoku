//
//  HowToPlayViewTests.swift
//  Sudoku
//
//  Created by Ray Kim on 8/16/25.
//  Copyright © 2025 Self. All rights reserved.
//

@testable import Sudoku

import SnapshotTesting
import Testing
import SwiftUI

@MainActor
struct HowToPlayViewTests {

    @Test(arguments: SnapshotTestHelper.devices)
    func testHowToPlayViewSnapshots(device: Device) async throws {
        guard let size = device.1.size else {
            return assertionFailure("missing size in SnapshotTesting")
        }
        let view = HowToPlayView().environment(WindowSize(size: size))
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(size: size), named: "\(device.0)Size")
        let darkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(of: vc, as: .image(size: size, traits: darkMode), named: "\(device.0)SizeDark")
    }
}
