//
//  RowViewModelTests.swift
//  SudokuTests
//
//  Created by Ray Kim on 4/1/24.
//  Copyright © 2024 Self. All rights reserved.
//

@testable import Sudoku

import SwiftUI
import XCTest

final class RowViewModelTests: XCTestCase {

    func testBackgroundColorForColumnIndexSelectedCellNil() {
        let viewModel = RowViewModel(index: 0, squareIndex: 0, guesses: [])
        let color = viewModel.backgroundColorFor(0, selectedCell: nil)
        let expectedColor = Color("dynamicGridWhite")

        XCTAssertTrue(color == expectedColor)
    }
    
    func testBackgroundColorForColumnIndexSelectedCellSameCoordinate() {
        let viewModel = RowViewModel(index: 0, squareIndex: 0, guesses: [])
        let selectedCell = Coordinate(r: 0, c: 0, s: 0)
        let color = viewModel.backgroundColorFor(0, selectedCell: selectedCell)
        let expectedColor = Color("dynamicBlueSelection")

        XCTAssertTrue(color == expectedColor)
    }
    
    func testBackgroundColorForColumnIndexSelectedCellSameSquare() {
        let viewModel = RowViewModel(index: 0, squareIndex: 0, guesses: [])
        let selectedCell = Coordinate(r: 1, c: 2, s: 0)
        let color = viewModel.backgroundColorFor(0, selectedCell: selectedCell)
        let expectedColor = Color("dynamicGridSelection")

        XCTAssertTrue(color == expectedColor)
    }
    
    func testBackgroundColorForColumnIndexSelectedCellDifferent() {
        let viewModel = RowViewModel(index: 0, squareIndex: 0, guesses: [])
        let selectedCell = Coordinate(r: 1, c: 2, s: 3)
        let color = viewModel.backgroundColorFor(0, selectedCell: selectedCell)
        let expectedColor = Color("dynamicGridWhite")

        XCTAssertTrue(color == expectedColor)
    }
    
    func testGuessesForColumnIndexNoGuesses() {
        let viewModel = RowViewModel(index: 0, squareIndex: 0, guesses: [])
        let guesses = viewModel.guessesFor(0)
        let expectedGuesses = Set<Int>()
        
        XCTAssertTrue(guesses == expectedGuesses)
    }
    
    func testGuessesForColumnIndexOneGuess() {
        let coordinateEditValues = CoordinateEditValues(r: 0, c: 0, s: 0, values: [0])
        let viewModel = RowViewModel(index: 0, squareIndex: 0, guesses: [coordinateEditValues])
        let guesses = viewModel.guessesFor(0)
        let expectedGuesses: Set<Int> = [0]
        
        XCTAssertTrue(guesses == expectedGuesses)
    }
}
