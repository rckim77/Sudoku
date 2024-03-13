//
//  SettingsView.swift
//  Sudoku
//
//  Created by Ray Kim on 6/30/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    private let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Sudoku AI")
                .font(Font.system(.largeTitle, design: .rounded).bold())
            Text("Version \(appVersion) (\(buildVersion))")
                .font(Font.system(.headline, design: .rounded))
            Text("© 2023 Ray Kim")
                .font(Font.system(.headline, design: .rounded))
            Button(action: {
                let url = URL(string: "https://www.facebook.com/Sudoku-Classic-105010301266062")!
                UIApplication.shared.open(url)
            }) {
                Text("Website")
                    .font(Font.system(.headline, design: .rounded))
            }
            Spacer()
        }
        .fullBackgroundStyle()
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
