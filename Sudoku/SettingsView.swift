//
//  SettingsView.swift
//  Sudoku
//
//  Created by Ray Kim on 6/30/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    
    #if os(visionOS)
    @State private var animate = false
    private let text = String(localized: "vision_special_message")
    #endif
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    private let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

    @State private var showingDeleteConfirmation = false
    @State private var showingCacheClearConfirmation = false

    var body: some View {
        VStack(spacing: 24) {
            Text("app_title")
                .font(Font.system(.largeTitle, design: .rounded).bold())
            Text("settings_version", locale: .current, arguments: appVersion, buildVersion)
                .font(Font.system(.headline, design: .rounded))
            Text("settings_copyright")
                .font(Font.system(.headline, design: .rounded))
            Button(action: {
                let url = URL(string: "https://www.facebook.com/Sudoku-Classic-105010301266062")!
                UIApplication.shared.open(url)
            }) {
                Text("settings_website")
                    .font(Font.system(.headline, design: .rounded))
            }
            Button(action: {
                // clear user defaults (e.g., achievements)
                if let bundleID = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
                }
                
                // clear persisted data (e.g., saved game)
                do {
                    try modelContext.delete(model: GameConfig.self)
                    try modelContext.save()
                } catch {
                    print("Error deleting SwiftData models: \(error)")
                }
                
                showingDeleteConfirmation = true
            }) {
                Text("settings_delete_data")
                    .font(Font.system(.headline, design: .rounded))
                    .foregroundColor(.red)
            }
            .alert("alert_data_deleted", isPresented: $showingDeleteConfirmation) {
                Button("alert_ok", role: .cancel) { }
            } message: {
                Text("alert_data_deleted_message")
            }
            Button(action: {
                HintButton.clearCache()
                showingCacheClearConfirmation = true
            }) {
                Text("settings_clear_cache")
                    .font(Font.system(.headline, design: .rounded))
                    .foregroundColor(.red)
            }
            .alert("alert_cache_cleared", isPresented: $showingCacheClearConfirmation) {
                Button("alert_ok", role: .cancel) { }
            } message: {
                Text("alert_cache_cleared_message")
            }
            #if os(visionOS)
            HStack(spacing: 0) {
                ForEach(0..<text.count, id: \.self) { index in
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(Font.system(.subheadline, design: .rounded))
                        .scaleEffect(animate ? 1.5 : 1.0)
                        .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.1 * Double(index)), value: animate)
                }
            }
            #endif
            Spacer()
        }
        .fullBackgroundStyle()
        .navigationTitle("Settings")
        #if os(visionOS)
        .onAppear {
            DispatchQueue.main.async {
                animate = true
            }
        }
        #endif
    }
}

#Preview {
    SettingsView()
}
