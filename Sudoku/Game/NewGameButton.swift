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

    @Binding
    var alert: AlertItem?
    @Binding
    var alertIsPresented: Bool

    let editGrid: [CoordinateEditValues]
    let startingGrid: [CoordinateValue]
    let workingGrid: [CoordinateValue]

    var body: some View {
        Button(action: {
            if self.workingGrid.count > self.startingGrid.count || !self.editGrid.isEmpty {
                self.alert = .newGame
                self.alertIsPresented = true
            } else {
                dismiss()
            }
        }) {
            Text("New game")
                .font(.system(.headline, design: .rounded))
        }
        .dynamicButtonStyle(backgroundColor: Color.blue.opacity(0.2))
    }
}

struct NewGameButton_Previews: PreviewProvider {
    static var previews: some View {
        NewGameButton(alert: .constant(.newGame),
                      alertIsPresented: .constant(false),
                      editGrid: [],
                      startingGrid: GridFactory.easyGrid,
                      workingGrid: GridFactory.easyGrid)
    }
}
