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
    
    private let backgroundColor = Color("dynamicGridWhite")
    private let selectedBackgroundColor = Color("dynamicGridSelection")
    
    func backgroundColorFor(_ columnIndex: Int) -> Color {
        return selectedColumnIndex == columnIndex ? selectedBackgroundColor : backgroundColor
    }
    
    func startingGridContainsAValue(at coordinate: Coordinate) -> Bool {
        let result = startingGrid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }
        return result
    }
    
    private func values(in squareIndex: Int) -> [CoordinateValue] {
        startingGrid.filter { coordinateValue -> Bool in
            coordinateValue.s == squareIndex
        }
    }
    
    func square(_ squareIndex: Int, contains value: Int) -> Bool {
        let squareValues = values(in: squareIndex)
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
}
