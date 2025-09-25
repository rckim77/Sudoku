//
//  NewGameButton.swift
//  Sudoku
//
//  Created by Ray Kim on 7/1/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct NewGameButton: View {

    @Environment(\.dismiss) private var dismiss

    @Binding var alert: AlertItem?
    @Binding var alertIsPresented: Bool

    let hasUpdatedGrid: Bool
    let savedState: SavedState

    var body: some View {
        Button(action: {
            if hasUpdatedGrid && savedState == .unsaved {
                self.alert = .newGame
                self.alertIsPresented = true
            } else {
                dismiss()
            }
        }) {
            Text("new_game")
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
    }
}

struct NewGameButton_Previews: PreviewProvider {
    static var previews: some View {
        NewGameButton(alert: .constant(.newGame),
                      alertIsPresented: .constant(false),
                      hasUpdatedGrid: true,
                      savedState: .saved)
    }
}
