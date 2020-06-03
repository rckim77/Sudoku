//
//  KeysRow.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct KeysRow: View {
    private let buttonHeight: CGFloat = 40
    var body: some View {
        HStack(spacing: 2) {
            Button(action: {}) {
                Text("1")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("2")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("3")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("4")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("5")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("6")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("7")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("8")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
            Button(action: {}) {
                Text("9")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: buttonHeight)
                    .background(Color.gray.opacity(0.4))
            }
                .cornerRadius(5)
        }
        .frame(maxWidth: .infinity)
    }
}

struct KeysRow_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            KeysRow()
            Spacer()
        }
    }
}
