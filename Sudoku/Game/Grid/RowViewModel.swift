//
//  RowViewModel.swift
//  Sudoku
//
//  Created by Ray Kim on 6/24/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

struct RowViewModel {

    let index: Int
    let columns = [0, 1, 2]
    let squareIndex: Int
    let startingGrid: [CoordinateValue]
    let workingGrid: [CoordinateValue]
    let guesses: [CoordinateEditValues]
    
    private let backgroundColor = Color("dynamicGridWhite")
    private let selectedBackgroundColor = Color("dynamicGridSelection")
    
    func backgroundColorFor(_ columnIndex: Int, selectedCell: Coordinate?) -> Color {
        guard let selectedCell = selectedCell else {
            return backgroundColor
        }
        
        let isinSameSquare = squareIndex == selectedCell.s
        let isInSameColumn = coordinateAt(columnIndex, isInSameColumnAs: selectedCell)
        let isInSameRow = coordinateAt(columnIndex, isInSameRowAs: selectedCell)
        
        // exact same coordinate
        if selectedCell.r == index && selectedCell.c == columnIndex && selectedCell.s == squareIndex {
            return Color("dynamicBlueSelection")
        } else if isinSameSquare || isInSameColumn || isInSameRow {
            return selectedBackgroundColor
        } else {
            return backgroundColor
        }
    }
    
    func createCoordinateValue(c: Int) -> CoordinateValue? {
        let coordinate = Coordinate(r: index, c: c, s: squareIndex)
        guard let value = workingGridRetrieveValue(at: coordinate) else {
            return nil
        }
        
        return CoordinateValue(r: index, c: c, s: squareIndex, v: value)
    }
    
    func hasGuessesAndNoValue(at columnIndex: Int) -> Bool {
        let coordinate = (r: index, c: columnIndex, s: squareIndex)
        return !grid(workingGrid, containsAValueAt: coordinate) && !guessFor(columnIndex).isEmpty
    }
    
    func guessFor(_ columnIndex: Int) -> Set<Int> {
        let coordinate = (r: index, c: columnIndex, s: squareIndex)
        return guesses.first(where: {
            $0.r == coordinate.r &&
            $0.c == coordinate.c &&
            $0.s == coordinate.s
        })?.values ?? Set<Int>()
    }
    
    // MARK: - Working grid methods
    
    func workingGridRetrieveValue(at coordinate: Coordinate) -> Int? {
        let squareValues = values(in: coordinate.s, grid: workingGrid)
        return squareValues.filter({ coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }).first?.v
    }
    
    // MARK: - Private helpers
    
    private func values(in squareIndex: Int, grid: [CoordinateValue]) -> [CoordinateValue] {
        grid.filter { coordinateValue -> Bool in
            coordinateValue.s == squareIndex
        }
    }
    
    private func grid(_ grid: [CoordinateValue], containsAValueAt coordinate: Coordinate) -> Bool {
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }
        return result
    }
    
    private func coordinateAt(_ columnIndex: Int, isInSameColumnAs selectedCoordinate: Coordinate) -> Bool {
        let leftSquareIndices = [0, 3, 6]
        let midSquareIndices = [1, 4, 7]
        let rightSquareIndices = [2, 5, 8]

        var isInSameColumn = false

        if leftSquareIndices.contains(squareIndex) && leftSquareIndices.contains(selectedCoordinate.s) && columnIndex == selectedCoordinate.c ||
            midSquareIndices.contains(squareIndex) && midSquareIndices.contains(selectedCoordinate.s) && columnIndex == selectedCoordinate.c ||
            rightSquareIndices.contains(squareIndex) && rightSquareIndices.contains(selectedCoordinate.s) && columnIndex == selectedCoordinate.c {
            isInSameColumn = true
        }

        return isInSameColumn
    }
    
    private func coordinateAt(_ columnIndex: Int, isInSameRowAs selectedCoordinate: Coordinate) -> Bool {
        let topSquareRowIndices = [0, 1, 2]
        let midSquareRowIndices = [3, 4, 5]
        let bottomSquareRowIndices = [6, 7, 8]

        var isInSameRow = false

        if topSquareRowIndices.contains(squareIndex) && topSquareRowIndices.contains(selectedCoordinate.s) && index == selectedCoordinate.r ||
            midSquareRowIndices.contains(squareIndex) && midSquareRowIndices.contains(selectedCoordinate.s) && index == selectedCoordinate.r ||
            bottomSquareRowIndices.contains(squareIndex) && bottomSquareRowIndices.contains(selectedCoordinate.s) && index == selectedCoordinate.r {
            isInSameRow = true
        }

        return isInSameRow
    }
}
