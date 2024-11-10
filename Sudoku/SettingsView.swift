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
    private let text = "Special shoutout to Don for helping me test this app for the Apple Vision Pro 🎉"
    #endif
    
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    private let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

    @State private var showingDeleteConfirmation = false

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
                Text("Delete saved data")
                    .font(Font.system(.headline, design: .rounded))
                    .foregroundColor(.red)
            }
            .alert("Data Deleted", isPresented: $showingDeleteConfirmation) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Data has been deleted successfully.")
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
