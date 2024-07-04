//
//  EditState.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/12/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

final class EditState: ObservableObject {
    @Published
    var isEditing: Bool = false
    
    init(isEditing: Bool = false) {
        self.isEditing = isEditing
    }
}
