//
//  GameViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/25/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct GameViewModel: ViewModel {
    
    let difficulty: Difficulty.Level

    var verticalSpacing: CGFloat {
        guard !isIpad else {
            return 60
        }

        if screenHeight > 736 { // taller than 8 Plus
            return 46
        } else if screenHeight > 667 { // 8 Plus
            return 24
        } else { // 8, SE (2nd gen)
            return 18
        }
    }

    var clearButtonHorizontalPadding: CGFloat {
        if screenHeight > 736 { // taller than 8 Plus
            return 22
        } else { // 8 Plus, 8, SE (2nd gen)
            return 14
        }
    }

    var clearButtonVerticalPadding: CGFloat {
        if screenHeight > 736 { // taller than 8 Plus
            return 10
        } else { // 8 Plus, 8, SE (2nd gen)
            return 8
        }
    }

    let actionButtonsHorizontalSpacing: CGFloat = 12
    
    func getHint(grid: [CoordinateValue]) async throws -> String? {
        do {
            guard let response = try await API.getHint(grid: grid), let first = response.choices.first else {
                return nil
            }
            return first.message.content
        } catch {
            return nil
        }
    }
}
