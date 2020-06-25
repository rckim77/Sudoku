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
    let columns: [Int]
    let squareIndex: Int
    let selectedColumnIndex: Int?
    let startingGrid: [CoordinateValue]
    let workingGrid: [CoordinateValue]
    let guesses: [CoordinateEditValues]
    
    private let backgroundColor = Color("dynamicGridWhite")
    private let selectedBackgroundColor = Color("dynamicGridSelection")
    
    func backgroundColorFor(_ columnIndex: Int) -> Color {
        return selectedColumnIndex == columnIndex ? selectedBackgroundColor : backgroundColor
    }
    
    func workingGridContainsAValue(at coordinate: Coordinate) -> Bool {
        return grid(workingGrid, containsAValueAt: coordinate)
    }

    
    func square(_ squareIndex: Int, contains value: Int) -> Bool {
        let squareValues = values(in: squareIndex, grid: startingGrid)
        return squareValues.contains { coordinateValue -> Bool in
            return coordinateValue.v == value
        }
    }
    
    func fullRow(for coordinate: Coordinate, contains value: Int) -> Bool {
        var rowCoordinates = [CoordinateValue]()

        if (0...2).contains(coordinate.s) {
            rowCoordinates = startingGrid.filter { coordinateValue -> Bool in
                return coordinateValue.r == coordinate.r && (0...2).contains(coordinateValue.s)
            }
        } else if (3...5).contains(coordinate.s) {
            rowCoordinates = startingGrid.filter { coordinateValue -> Bool in
                return coordinateValue.r == coordinate.r && (3...5).contains(coordinateValue.s)
            }
        } else if (6...8).contains(coordinate.s) {
            rowCoordinates = startingGrid.filter { coordinateValue -> Bool in
                return coordinateValue.r == coordinate.r && (6...8).contains(coordinateValue.s)
            }
        }

        var containsValueInRow = false
        for coordinate in rowCoordinates {
            if coordinate.v == value {
                containsValueInRow = true
                break
            }
        }
        return containsValueInRow
    }
    
    func fullColumn(for coordinate: Coordinate, contains value: Int) -> Bool {
        var colCoordinates = [CoordinateValue]()

        if [0, 3, 6].contains(coordinate.s) {
            colCoordinates = startingGrid.filter { coordinateValue -> Bool in
                return coordinateValue.c == coordinate.c && [0, 3, 6].contains(coordinateValue.s)
            }
        } else if [1, 4, 7].contains(coordinate.s) {
            colCoordinates = startingGrid.filter { coordinateValue -> Bool in
                return coordinateValue.c == coordinate.c && [1, 4, 7].contains(coordinateValue.s)
            }
        } else if [2, 5, 8].contains(coordinate.s) {
            colCoordinates = startingGrid.filter { coordinateValue -> Bool in
                return coordinateValue.c == coordinate.c && [2, 5, 8].contains(coordinateValue.s)
            }
        }

        var containsValueInCol = false
        for coordinate in colCoordinates {
            if coordinate.v == value {
                containsValueInCol = true
                break
            }
        }
        return containsValueInCol
    }
    
    func guessFor(_ columnIndex: Int) -> Set<Int> {
        let coordinate = (r: index, c: columnIndex, s: squareIndex)
        return guesses.first(where: {
            $0.r == coordinate.r &&
            $0.c == coordinate.c &&
            $0.s == coordinate.s
        })?.values ?? Set<Int>()
    }
    
    /// Compares working grid and starting grid and returns whether there's a value at the
    /// specified coordinate only in the working grid.
    func onlyWorkingGridHasValue(at coordinate: Coordinate) -> Bool {
        let workingGridHasAValue = grid(workingGrid, containsAValueAt: coordinate)
        let startingGridHasAValue = grid(startingGrid, containsAValueAt: coordinate)
        return workingGridHasAValue && !startingGridHasAValue
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
}
