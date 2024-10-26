//
//  StatsView.swift
//  Sudoku
//
//  Created by Ray Kim on 10/19/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct StatsView: View {

    @AppStorage("totalGamesCompleted") var totalGamesCompleted = 0
    @AppStorage("totalEasyGamesCompleted") var totalEasyGamesCompleted = 0
    @AppStorage("totalMediumGamesCompleted") var totalMediumGamesCompleted = 0
    @AppStorage("totalHardGamesCompleted") var totalHardGamesCompleted = 0
    
    var body: some View {
        List {
            StatsRow(title: "Total games completed", value: "\(totalGamesCompleted)")
            Section("Difficulty") {
                StatsRow(title: "Easy", value: "\(totalEasyGamesCompleted)")
                StatsRow(title: "Medium", value: "\(totalMediumGamesCompleted)")
                StatsRow(title: "Hard", value: "\(totalHardGamesCompleted)")
            }
        }
        .font(Font.system(.headline, design: .rounded))
        .fullBackgroundStyle()
        .navigationTitle("Stats")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    StatsView()
}
