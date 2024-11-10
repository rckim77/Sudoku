//
//  HintButton.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import SwiftUI

struct HintButton: View {

    @Binding var alertItem: AlertItem?
    @Binding var alertIsPresented: Bool
    let grid: [CoordinateValue]
    let difficulty: Difficulty.Level

    @State private var isLoading = false
    
    var body: some View {
        Button("Hint", systemImage: "lightbulb.max") {
            Task {
                await getHint()
            }
        }
        .tint(.primary)
        .symbolEffect(.pulse, value: isLoading)
        .disabled(isLoading)
    }
    
    private func getHint() async {
        do {
            isLoading = true
            if let response = try await API.getHint(grid: grid, difficulty: difficulty), let hintMessage = response.choices.first?.message.content {
                alertItem = .hintSuccess(hint: hintMessage)
                alertIsPresented = true
            } else {
                alertItem = .hintError
                alertIsPresented = true
            }
        } catch {
            alertItem = .hintError
            alertIsPresented = true
        }
        isLoading = false
    }
}
