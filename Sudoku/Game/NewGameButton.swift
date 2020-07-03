//
//  NewGameButton.swift
//  Sudoku
//
//  Created by Ray Kim on 7/1/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct NewGameButton: View {
    @Environment(\.presentationMode)
    private var presentationMode: Binding<PresentationMode>

    @Binding
    var alert: AlertItem?

    let editGrid: [CoordinateEditValues]
    let startingGrid: [CoordinateValue]
    let workingGrid: [CoordinateValue]

    var body: some View {
        Button(action: {
            if self.workingGrid.count > self.startingGrid.count || !self.editGrid.isEmpty {
                self.alert = AlertItem(id: .newGame)
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("New game")
                .font(.system(.headline, design: .rounded))
        }
            .menuButtonStyle()
    }
}

struct NewGameButton_Previews: PreviewProvider {
    static var previews: some View {
        NewGameButton(alert: .constant(AlertItem(id: .newGame)),
                      editGrid: [],
                      startingGrid: GridFactory.easyGrid,
                      workingGrid: GridFactory.easyGrid)
    }
}
