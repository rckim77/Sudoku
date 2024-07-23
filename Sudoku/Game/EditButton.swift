//
//  EditButton.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct EditButton: View {

    var editState: EditState

    private var imageSize: CGFloat {
        isIpad ? 24 : 18
    }
    private var backgroundColor: Color {
        editState.isEditing ? Color("dynamicDarkGray") : Color("dynamicGray")
    }
    private var imageName: String {
        editState.isEditing ? "pencil.circle.fill" : "pencil.circle"
    }

    var body: some View {
        Button("Edit", systemImage: editState.isEditing ? "square.and.pencil.circle.fill" : "square.and.pencil.circle") {
            self.editState.isEditing.toggle()
        }
        .contentTransition(.symbolEffect(.replace))
        .tint(.primary)
    }
}
