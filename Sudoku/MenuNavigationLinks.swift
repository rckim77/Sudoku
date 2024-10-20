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
            NavigationLink {
                StatsView()
            } label: {
                Label("Stats", systemImage: "chart.bar")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                HowToPlayView()
            } label: {
                Label("How to play", systemImage: "questionmark.circle")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                SettingsView()
            } label: {
                Label("Settings", systemImage: "gear")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
        }
        #else
        VStack(spacing: 18) {
            NavigationLink {
                StatsView()
            } label: {
                Label("Stats", systemImage: "chart.bar")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                HowToPlayView()
            } label: {
                Label("How to play", systemImage: "questionmark.circle")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
            NavigationLink {
                SettingsView()
            } label: {
                Label("Settings", systemImage: "gear")
                    .font(.system(.headline, design: .rounded))
                    .tint(Color("dynamicDarkGray"))
            }
        }
        #endif
    }
}

#Preview {
    MenuNavigationLinks()
}
