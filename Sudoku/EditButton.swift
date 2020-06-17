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

    private let editButtonHorizontalPadding: CGFloat = 14
    private var editButtonVerticalPadding: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 736 { // taller than 8 Plus
            return 18
        } else { // 8 Plus, 8, SE (2nd gen)
            return 16
        }
    }

    var body: some View {
        Button(action: {
            self.editState.isEditing.toggle()
        }) {
            Image(systemName: editState.isEditing ? "pencil.circle.fill" : "pencil.circle")
                .font(.system(size: 24, weight: .regular))
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
