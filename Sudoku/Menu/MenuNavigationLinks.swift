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
        #if os(visionOS)
        HStack(spacing: 18) {
            navigationLinks
        }
        #else
        VStack(spacing: 18) {
            navigationLinks
        }
        #endif
    }
    
    private var navigationLinks: some View {
        Group {
            NavigationLink {
                StatsView()
            } label: {
                Label("nav_stats", systemImage: "chart.bar")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                HowToPlayView()
            } label: {
                Label("nav_how_to_play", systemImage: "questionmark.circle")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                SettingsView()
            } label: {
                Label("nav_settings", systemImage: "gear")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
        }
    }
}

#Preview {
    MenuNavigationLinks()
}
