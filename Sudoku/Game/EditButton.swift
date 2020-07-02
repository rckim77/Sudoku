//
//  EditButton.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct EditButton: View {

    @EnvironmentObject
    private var editState: EditState

    private var editButtonHorizontalPadding: CGFloat {
        isIpad ? 20 : 14
    }
    private var editButtonVerticalPadding: CGFloat {
        isIpad ? 26 : 16
    }
    private var imageSize: CGFloat {
        isIpad ? 30 : 24
    }

    var body: some View {
        Button(action: {
            self.editState.isEditing.toggle()
        }) {
            Image(systemName: editState.isEditing ? "pencil.circle.fill" : "pencil.circle")
                .font(.system(size: imageSize, weight: .regular))
                .foregroundColor(.black)
                .padding(.horizontal, editButtonHorizontalPadding)
                .padding(.vertical, editButtonVerticalPadding)
                .background(editState.isEditing ? Color("dynamicDarkGray") : Color("dynamicGray"))
        }
            .cornerRadius(8)
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ClearButton()
            EditButton()
                .environmentObject(EditState())
        }
    }
}
