//
//  HintButton.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import SwiftUI

struct HintButton: View {

    @Binding
    var isLoading: Bool
    var action: () -> Void
    
    var body: some View {
        Button("Hint", systemImage: "lightbulb.max") {
            action()
        }
        .symbolEffect(.pulse, isActive: isLoading)
        .tint(.primary)
    }
}
