//
//  Grid.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Grid: View {
    @EnvironmentObject
    var selectedCell: SelectedCell

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack {
                HStack(spacing: 0) {
                    Square(index: 0)
                    Square(index: 1)
                    Square(index: 2)
                }
                HStack(spacing: 0) {
                    Square(index: 3)
                    Square(index: 4)
                    Square(index: 5)
                }
                HStack(spacing: 0) {
                    Square(index: 6)
                    Square(index: 7)
                    Square(index: 8)
                }
            }
            Spacer()
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
    }
}
