//
//  StatsRow.swift
//  Sudoku
//
//  Created by Assistant on 3/14/2024.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct StatsRow: View {
    let title: LocalizedStringKey
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .tint(Color("dynamicDarkGray"))
        }
    }
}

#Preview {
    StatsRow(title: "stats.total-games", value: "42")
}
