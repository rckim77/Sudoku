//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Sudoku")
                .font(.title)
            Grid()
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                KeysRow()
                Spacer()
            }
            Spacer()
            Button(action: {}) {
                Text("Clear")
                    .foregroundColor(.black)
            }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(8)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
