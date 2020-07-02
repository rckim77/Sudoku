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

    let editGridIsEmpty: Bool
    let workingGridHasMoreValues: Bool

    var body: some View {
        Button(action: {
            if self.workingGridHasMoreValues || !self.editGridIsEmpty {
                self.alert = AlertItem(id: .newGame)
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("New game")
        }
            .menuButtonStyle()
    }
}

struct NewGameButton_Previews: PreviewProvider {
    static var previews: some View {
        NewGameButton(alert: .constant(AlertItem(id: .newGame)), editGridIsEmpty: true, workingGridHasMoreValues: true)
    }
}
