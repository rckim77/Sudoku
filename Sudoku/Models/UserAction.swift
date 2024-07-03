//
//  UserAction.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/4/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

final class UserAction: ObservableObject {
    enum ActionType: Equatable, Codable {
        case none
        case clear
        case digit(_ digit: Int)
    }
    @Published
    var action: ActionType = .none
    
    init(action: ActionType = .none) {
        self.action = action
    }
}
