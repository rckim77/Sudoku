//
//  SnapshotTestHelper.swift
//  SudokuTests
//
//  Created by Ray Kim on 8/16/25.
//  Copyright © 2025 Self. All rights reserved.
//

import Testing
import SnapshotTesting

typealias Device = (String, ViewImageConfig)

/*
 
Note: The devices will have to be updated over time as we drop iOS support for
 certain devices and the SnapshotTesting Swift package gets updated with newer
 screen sizes.
 
.iPhone13 size is equivalent to iPhone 13 Pro, 14, 12 Pro, and 12
.iPhone13ProMax size is equivalent to iPhone 12 Pro Max and 14 Plus
.iPhone13Mini size is equivalent to iPhone 12 mini

*/
public struct SnapshotTestHelper {
    static let devices: [Device] = [("iPhone13Mini", .iPhone13Mini),
                                    ("iPhone13", .iPhone13),
                                    ("iPhone13ProMax", .iPhone13ProMax),
                                    ("iPad10_2", .iPad10_2(.portrait)),
                                    ("iPad12_9", .iPadPro12_9(.portrait))]
}
