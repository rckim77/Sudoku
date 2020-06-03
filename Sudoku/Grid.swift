//
//  Grid.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct Grid: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                VStack {
                    Square()
                    Square()
                    Square()
                }
                VStack {
                    Square()
                    Square()
                    Square()
                }
                VStack {
                    Square()
                    Square()
                    Square()
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
