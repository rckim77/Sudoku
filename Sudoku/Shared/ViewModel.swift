//
//  ViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

@MainActor
protocol ViewModel {
    var isIpad: Bool { get }
    var isVision: Bool { get }
    var isIphone: Bool { get }
}

extension ViewModel {
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var isVision: Bool {
        UIDevice.current.userInterfaceIdiom == .vision
    }
    
    var isIphone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
