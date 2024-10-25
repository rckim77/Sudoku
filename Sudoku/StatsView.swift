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
    
    var body: some View {
        List {
            HStack {
                Text("Total games completed")
                Spacer()
                Text("\(totalGamesCompleted)")
                    .tint(Color("dynamicDarkGray"))
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
