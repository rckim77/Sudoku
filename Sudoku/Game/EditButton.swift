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

    private var editButtonHorizontalPadding: CGFloat {
        if #available(iOS 14.0, *) {
            return isIpad ? 20 : 10
        }
        return isIpad ? 24 : 14
    }
    private var editButtonVerticalPadding: CGFloat {
        if #available(iOS 14.0, *) {
            return isIpad ? 20 : 10
        }
        return isIpad ? 26 : 16
    }
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
        Button(action: {
            self.editState.isEditing.toggle()
        }) {
            Image(systemName: imageName)
                .font(.system(size: imageSize, weight: .regular))
        }
        .dynamicButtonImageStyle(textColor: .black, backgroundColor: backgroundColor)
    }
}
