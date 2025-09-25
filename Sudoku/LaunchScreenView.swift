//
//  LaunchScreenView.swift
//  Sudoku
//
//  Created by Copilot on 12/25/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            // Use the same dynamic background color as the rest of the app
            Color("dynamicBackground")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Match the style used in MenuView but with system font to match the original storyboard
                Text("Sudoku AI")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                Spacer() // Additional spacer to better match the storyboard layout
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}

#Preview("Dark Mode") {
    LaunchScreenView()
        .preferredColorScheme(.dark)
}