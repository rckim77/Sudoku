//
//  HintButton.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import SwiftUI

struct HintButton: View {

    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Hint")
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
    }
}
