//
//  Hint.swift
//  Sudoku
//
//  Created by Ray Kim on 2/9/25.
//  Copyright © 2025 Self. All rights reserved.
//

import Foundation

struct Hint {
    enum HintType {
        case nakedSingle
        case hiddenSingle
        case open
        
        var rawValue: String {
            switch self {
            case .nakedSingle:
                return "There is at least one naked single on this board. Can you find it?"
            case .hiddenSingle:
                return "There is at least one hidden single on this board. Can you find it?"
            case .open:
                return "fallback"
            }
        }
    }
    let coordinate: CoordinateValue?
    let hintType: HintType
    private let overrideDescription: String?
    
    init(coordinate: CoordinateValue? = nil, hintType: HintType, overrideDescription: String? = nil) {
        self.coordinate = coordinate
        self.hintType = hintType
        self.overrideDescription = overrideDescription
    }
    
    var description: String {
        return overrideDescription ?? hintType.rawValue
    }
}
