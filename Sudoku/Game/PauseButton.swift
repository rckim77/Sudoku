//
//  PauseButton.swift
//  Sudoku
//
//  Created by Ray Kim on 12/14/25.
//  Copyright © 2025 Self. All rights reserved.
//

import SwiftUI

struct PauseButton: View {
    
    @Binding var isPaused: Bool
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPaused.toggle()
            }
        } label: {
            Image(systemName: isPaused ? "play.fill" : "pause.fill")
                .contentTransition(.symbolEffect(.replace))
        }
        .tint(.primary)
    }
}
