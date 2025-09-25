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
            return String(localized: "time_format_hours_minutes_seconds", defaultValue: "%d hours, %d minutes, and %d seconds", table: nil, locale: .current, arguments: hours, minutes, seconds)
        } else if minutes > 0 {
            return String(localized: "time_format_minutes_seconds", defaultValue: "%d minutes and %d seconds", table: nil, locale: .current, arguments: minutes, seconds)
        } else {
            return String(localized: "time_format_seconds", defaultValue: "%d seconds", table: nil, locale: .current, arguments: seconds)
        }
    }
    
    var body: some View {
        List {
            if let formattedFastestTime = formattedFastestTime {
                StatsRow(title: String(localized: "stats_fastest_time"), value: formattedFastestTime)
            }
            StatsRow(title: String(localized: "stats_total_games"), value: "\(totalGamesCompleted)")
            Section(String(localized: "stats_section_difficulty")) {
                StatsRow(title: String(localized: "stats_easy"), value: "\(totalEasyGamesCompleted)")
                StatsRow(title: String(localized: "stats_medium"), value: "\(totalMediumGamesCompleted)")
                StatsRow(title: String(localized: "stats_hard"), value: "\(totalHardGamesCompleted)")
            }
        }
        .font(Font.system(.headline, design: .rounded))
        .fullBackgroundStyle()
        .navigationTitle("stats_title")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    StatsView()
}
