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

    var verticalSpacing: CGFloat = 24
    var backgroundCornerRadius: CGFloat {
        isVision ? 32 : 0
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
    
    func getSpacerMaxHeight(_ geometryHeight: CGFloat) -> CGFloat {
        let verticalThreshold: CGFloat = 900
        return geometryHeight > verticalThreshold ? 60 : 28
    }
}
