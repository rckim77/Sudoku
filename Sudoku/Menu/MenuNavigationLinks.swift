//
//  MenuNavigationLinks.swift
//  Sudoku
//
//  Created by Ray Kim on 10/19/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct MenuNavigationLinks: View {

    var body: some View {
        VStack(spacing: 18) {
            NavigationLink {
                StatsView()
            } label: {
                Label("stats.title", systemImage: "chart.bar")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                HowToPlayView()
            } label: {
                Label("how-to-play.title", systemImage: "questionmark.circle")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                SettingsView()
            } label: {
                Label("settings.title", systemImage: "gear")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
        }
    }
}

#Preview {
    MenuNavigationLinks()
}
