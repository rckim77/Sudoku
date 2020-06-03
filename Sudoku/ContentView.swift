//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Row: View {
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {}) {
                Text("1")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            Button(action: {}) {
                Text("2")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            Button(action: {}) {
                Text("3")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity)
    }
}

struct Cell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Row()
            Row()
            Row()
        }
        .border(Color.black, width: 3)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Sudoku")
                .font(.largeTitle)
            HStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    VStack {
                        Cell()
                        Cell()
                        Cell()
                    }
                    VStack {
                        Cell()
                        Cell()
                        Cell()
                    }
                    VStack {
                        Cell()
                        Cell()
                        Cell()
                    }
                }
                Spacer()
            }
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
