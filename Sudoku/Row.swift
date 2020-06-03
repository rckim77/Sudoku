//
//  Row.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Row: View {
    @State
    private var selectedIndex: Int?
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                if self.selectedIndex == 0 {
                    self.selectedIndex = nil
                } else {
                    self.selectedIndex = 0
                }
            }) {
                Text("1")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(selectedIndex == 0 ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                if self.selectedIndex == 1 {
                    self.selectedIndex = nil
                } else {
                    self.selectedIndex = 1
                }
            }) {
                Text("2")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(selectedIndex == 1 ? Color.gray.opacity(0.4) : Color.white)
            Button(action: {
                if self.selectedIndex == 2 {
                    self.selectedIndex = nil
                } else {
                    self.selectedIndex = 2
                }
            }) {
                Text("3")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .background(selectedIndex == 2 ? Color.gray.opacity(0.4) : Color.white)
        }
        .frame(maxWidth: .infinity)
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row()
    }
}
