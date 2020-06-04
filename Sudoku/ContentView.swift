//
//  ContentView.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject
    var selectedCell: SelectedCell
    @EnvironmentObject
    var userAction: UserAction

    private var verticalSpacing: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 736 { // taller than 8 Plus
            return 40
        } else if screenHeight > 667 { // 8 Plus
            return 26
        } else { // 8, SE (2nd gen)
            return 20
        }
    }

    private var clearButtonHorizontalPadding: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 736 { // taller than 8 Plus
            return 24
        } else { // 8 Plus, 8, SE (2nd gen)
            return 16
        }
    }

    private var clearButtonVerticalPadding: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 736 { // taller than 8 Plus
            return 12
        } else { // 8 Plus, 8, SE (2nd gen)
            return 10
        }
    }

    private let clearButtonFont = Font.system(.title, design:.rounded).smallCaps()

    var body: some View {
        VStack(spacing: verticalSpacing) {
            Text("Sudoku")
                .font(.title)
            Grid()
            KeysRow()
            Button(action: {
                self.userAction.action = .clear
            }) {
                Text("Clear")
                    .foregroundColor(.black)
                    .font(clearButtonFont)
            }
                .padding(.horizontal, clearButtonHorizontalPadding)
                .padding(.vertical, clearButtonVerticalPadding)
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
