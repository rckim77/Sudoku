//
//  HowToPlayView.swift
//  Sudoku
//
//  Created by Ray Kim on 3/12/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct HowToPlayView: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Sudoku is a puzzle where you fill all the individual digit squares inside a grid with the right digit. But what determines the right digit? There are a few requirements that must be met:")
                Text("First, every row in the grid must include the numbers 1 to 9. Each digit can only appear once.")
                StaticGridView(highlightSection: .row)
                Text("Second, every column in the grid must also include the numbers 1 to 9 exactly once.")
                StaticGridView(highlightSection: .column)
                Text("Third, you'll notice that a Sudoku grid contains 9 squares within it. Each square must also only contain the numbers 1 to 9, once per digit.")
                StaticGridView(highlightSection: .square)
                Text("If all three conditions are met, then the Sudoku grid has been solved.")
                Text("The difficulty of a Sudoku puzzle can range depending on how many digits are already filled out at the beginning of the puzzle. Good luck and have fun solving them!")
            }
            .padding(16)
        }
        .navigationTitle("How to play")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    HowToPlayView()
}
