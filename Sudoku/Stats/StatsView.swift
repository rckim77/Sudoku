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
    @AppStorage("fastestTimeCompleted") var fastestTimeCompleted: TimeInterval?
    
    private var formattedFastestTime: String? {
        guard let fastestTime = fastestTimeCompleted else { return nil }
        
        let hours = Int(fastestTime) / 3600
        let minutes = Int(fastestTime) / 60 % 60
        let seconds = Int(fastestTime) % 60
        
        if hours > 0 {
            return "\(hours) hours, \(minutes) minutes, and \(seconds) seconds"
        } else if minutes > 0 {
            return "\(minutes) minutes and \(seconds) seconds"
        } else {
            return "\(seconds) seconds"
        }
    }
    
    var body: some View {
        List {
            if let formattedFastestTime = formattedFastestTime {
                StatsRow(title: "stats.fastest-time", value: formattedFastestTime)
            }
            StatsRow(title: "stats.total-games", value: "\(totalGamesCompleted)")
            Section("stats.section-title.difficulty") {
                StatsRow(title: "difficulty.easy", value: "\(totalEasyGamesCompleted)")
                StatsRow(title: "difficulty.medium", value: "\(totalMediumGamesCompleted)")
                StatsRow(title: "difficulty.hard", value: "\(totalHardGamesCompleted)")
            }
        }
        .font(Font.system(.headline, design: .rounded))
        .fullBackgroundStyle()
        .navigationTitle("stats.title")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    StatsView()
}
