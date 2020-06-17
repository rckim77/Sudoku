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
    private var selectedCell: SelectedCell
    @EnvironmentObject
    private var userAction: UserAction
    @EnvironmentObject
    private var editState: EditState
    @EnvironmentObject
    private var startingGrid: StartingGridValues
    @EnvironmentObject
    private var workingGrid: GridValues
    @EnvironmentObject
    private var editGrid: EditGridValues
    @EnvironmentObject
    private var difficulty: Difficulty

    @State
    private var workingGridIsComplete = false

    private var verticalSpacing: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 736 { // taller than 8 Plus
            return 48
        } else if screenHeight > 667 { // 8 Plus
            return 26
        } else { // 8, SE (2nd gen)
            return 20
        }
    }

    private var clearButtonHorizontalPadding: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 736 { // taller than 8 Plus
            return 22
        } else { // 8 Plus, 8, SE (2nd gen)
            return 14
        }
    }

    private var clearButtonVerticalPadding: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 736 { // taller than 8 Plus
            return 10
        } else { // 8 Plus, 8, SE (2nd gen)
            return 8
        }
    }

    var body: some View {
        VStack(spacing: verticalSpacing) {
            Grid()
            HStack(spacing: 4) {
                ClearButton()
                EditButton()
            }
            KeysRow(gridIsComplete: $workingGridIsComplete)
            DifficultyButtons()
        }
        .alert(isPresented: $workingGridIsComplete) {
            Alert(title: Text("Congratulations!"), message: Text("You've completed the sudoku!"), dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
