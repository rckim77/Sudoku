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
        
        var localizedKey: LocalizedStringResource {
            switch self {
            case .nakedSingle:
                return "hint.naked-single"
            case .hiddenSingle:
                return "hint.hidden-single"
            case .open: // not applicable for localization
                return ""
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
        return overrideDescription ?? String(localized: hintType.localizedKey)
    }
}
