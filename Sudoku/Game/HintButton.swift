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
        Button(action: {
            action()
        }) {
            if isLoading {
                ProgressView()
                    .tint(Color.blue)
            } else {
                Text("Hint")
                    .font(.system(.headline, design: .rounded))
            }
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
        .animation(.default, value: isLoading)
    }
}
