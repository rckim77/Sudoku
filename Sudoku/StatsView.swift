//
//  StatsView.swift
//  Sudoku
//
//  Created by Ray Kim on 10/19/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    @AppStorage("gamesCompleted") private var gamesCompleted = 0
    
    var body: some View {
        List {
            Section("Achievements") {
                HStack {
                    Text("Games Completed")
                    Spacer()
                    Text("\(gamesCompleted)")
                        .foregroundColor(.secondary)
                }
            }
        }
        .font(Font.system(.headline, design: .rounded))
        .fullBackgroundStyle()
        .navigationTitle("Statistics")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    StatsView()
}
