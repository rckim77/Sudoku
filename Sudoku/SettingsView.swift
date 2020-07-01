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

    var body: some View {
        NavigationView {
            ZStack {
                Color("dynamicBackground")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 40) {
                    Text("Sudoku Classic")
                        .font(Font.system(.largeTitle, design: .rounded).bold())
                    Text("Version \(appVersion)")
                        .font(Font.system(.title, design: .rounded))
                    Text("© 2020 Ray Kim")
                        .font(Font.system(.title, design: .rounded))
                    Button(action: {
                        let url = URL(string: "https://www.facebook.com/Sudoku-Classic-105010301266062")!
                        UIApplication.shared.open(url)
                    }) {
                        Text("Website")
                            .font(Font.system(.title, design: .rounded))
                    }
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("Settings", displayMode: .automatic)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
        }
    }
}
