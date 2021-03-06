//
//  GridValues.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/7/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI
import Combine

/// Maintains state for working grid `grid`. `startingGrid` contains the initial grid.
final class GridValues: ObservableObject {
    @Published
    private(set) var grid: [CoordinateValue]
    
    @Published
    private(set) var colorGrid: [CoordinateColor]
    
    private(set) var startingGrid: [CoordinateValue]

    var isSolved: Bool {
        return SudokuSolver.gridIsSolved(self)
    }

    /// When initialized, both the working and starting grids are identical.
    init(startingGrid: [CoordinateValue]) {
        self.grid = startingGrid
        self.startingGrid = startingGrid
        self.colorGrid = []
        self.initColorGrid(grid)
    }

    func values(in squareIndex: Int, grid: [CoordinateValue]) -> [CoordinateValue] {
        grid.filter { coordinateValue -> Bool in
            coordinateValue.s == squareIndex
        }
    }

    func reset(newGrid: [CoordinateValue]) {
        grid = newGrid
        startingGrid = newGrid
        initColorGrid(grid)
    }

    func add(_ coordinateValue: CoordinateValue) {
        let coordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
        removeValue(at: coordinate)
        grid.append(coordinateValue)
        updateColorGrid(coordinateValue)
    }

    func removeValue(at coordinate: Coordinate) {
        grid.removeAll { coordinateValue -> Bool in
            coordinateValue.r == coordinate.r && coordinateValue.c == coordinate.c && coordinateValue.s == coordinate.s
        }
    }

    func containsAValue(at coordinate: Coordinate, grid: [CoordinateValue]) -> Bool {
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }
        return result
    }

    func contains(value: Int, at coordinate: Coordinate) -> Bool {
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate && coordinateValue.v == value
        }
        return result
    }

    func retrieveValue(at coordinate: Coordinate, grid: [CoordinateValue]) -> Int? {
        let squareValues = values(in: coordinate.s, grid: grid)
        return squareValues.filter({ coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }).first?.v
    }

    // MARK: - Private methods

    private func contains(_ coordinateValue: CoordinateValue, grid: [CoordinateValue]) -> Bool {
        let squareValues = values(in: coordinateValue.s, grid: grid)
        return squareValues.first { coordinateVal -> Bool in
            coordinateVal == coordinateValue
        } != nil
    }
    
    /// Compares working grid and starting grid and returns whether there's a value at the
    /// specified coordinate only in the working grid.
    private func onlyWorkingGridHasValue(at coordinate: Coordinate) -> Bool {
        let workingGridHasAValue = grid(grid, containsAValueAt: coordinate)
        let startingGridHasAValue = grid(startingGrid, containsAValueAt: coordinate)
        return workingGridHasAValue && !startingGridHasAValue
    }
    
    private func updateColorGrid(_ coordinateValue: CoordinateValue) {
        guard onlyWorkingGridHasValue(at: coordinateValue.coordinate) else {
            // starting grid
            let coordinateColor = CoordinateColor(coordinate: coordinateValue, color: .black)
            colorGrid.append(coordinateColor)
            return
        }
        
        if value(coordinateValue.v, wouldBeInvalidAt: coordinateValue.coordinate) {
            // user has just entered an invalid digit
            let coordinateColor = CoordinateColor(coordinate: coordinateValue, color: .red)
            colorGrid.append(coordinateColor)
        } else {
            let coordinateColor = CoordinateColor(coordinate: coordinateValue, color: Color("dynamicBlue"))
            colorGrid.append(coordinateColor)
        }
    }
    
    private func grid(_ grid: [CoordinateValue], containsAValueAt coordinate: Coordinate) -> Bool {
        let result = grid.contains { coordinateValue -> Bool in
            let gridCoordinate = (r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }
        return result
    }
    
    /// Checks whether there's already a coordinate with the input value in the
    /// current coordinate's 3x3 square, starting grid row, or starting grid column.
    private func value(_ value: Int, wouldBeInvalidAt coordinate: Coordinate) -> Bool {
        return square(coordinate.s, contains: value) ||
            fullRow(for: coordinate, contains: value) ||
            fullColumn(for: coordinate, contains: value)
    }
    
    private func square(_ squareIndex: Int, contains value: Int) -> Bool {
        let squareValues = values(in: squareIndex, grid: startingGrid)
        return squareValues.contains { coordinateValue -> Bool in
            return coordinateValue.v == value
        }
    }
    
    private func fullRow(for coordinate: Coordinate, contains value: Int) -> Bool {
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
    
    private func fullColumn(for coordinate: Coordinate, contains value: Int) -> Bool {
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
    
    private func initColorGrid(_ grid: [CoordinateValue]) {
        colorGrid = grid.map { coordinateValue -> CoordinateColor in
            CoordinateColor(coordinate: coordinateValue, color: .black)
        }
    }
}


