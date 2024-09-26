//
//  GridValues.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/7/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

/// Maintains state for working grid `grid`. `startingGrid` contains the initial grid.
@Observable final class GridValues {

    private(set) var grid: [CoordinateValue]
    private(set) var colorGrid: Set<CoordinateColor>
    private(set) var startingGrid: [CoordinateValue]

    var isSolved: Bool {
        return SudokuSolver.gridIsSolved(self)
    }
    
    /// Used when starting a brand new game
    init(startingGrid: [CoordinateValue]) {
        self.grid = startingGrid
        self.startingGrid = startingGrid
        self.colorGrid = Set<CoordinateColor>()
        self.populateEmptyColorGrid(grid)
    }

    /// Used when loading from a saved game.
    init(grid: [CoordinateValue], startingGrid: [CoordinateValue], colorGrid: Set<CoordinateColor>?) {
        self.grid = grid
        self.startingGrid = startingGrid

        if let colorGrid = colorGrid {
            self.colorGrid = colorGrid
        } else {
            self.colorGrid = Set<CoordinateColor>()
            self.populateEmptyColorGrid(grid)
        }
    }

    func values(in squareIndex: Int, grid: [CoordinateValue]) -> [CoordinateValue] {
        grid.filter { coordinateValue -> Bool in
            coordinateValue.s == squareIndex
        }
    }

    func resetTo(newGrid: [CoordinateValue]) {
        grid = newGrid
        startingGrid = newGrid
        populateEmptyColorGrid(grid)
    }
    
    func resetFrom(savedGame: SavedGameState) {
        grid = savedGame.workingGrid
        startingGrid = savedGame.startingGrid
        colorGrid = savedGame.colorGrid
    }

    func add(_ coordinateValue: CoordinateValue) {
        let coordinate = Coordinate(r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
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
            let gridCoordinate = Coordinate(r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }
        return result
    }

    func getValue(at coordinate: Coordinate, grid: [CoordinateValue]) -> Int? {
        let squareValues = values(in: coordinate.s, grid: grid)
        return squareValues.filter({ coordinateValue -> Bool in
            let gridCoordinate = Coordinate(r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }).first?.v
    }
    
    func getCoordinateValue(at coordinate: Coordinate, grid: [CoordinateValue]) -> CoordinateValue? {
        return grid.filter({ coordinateValue -> Bool in
            let gridCoordinate = Coordinate(r: coordinateValue.r, c: coordinateValue.c, s: coordinateValue.s)
            return gridCoordinate == coordinate
        }).first
    }
    
    func foregroundColorFor(_ coordinate: CoordinateValue) -> Color? {
        colorGrid.first(where: { $0.coordinate == coordinate })?.color
    }

    // MARK: - Private methods
    
    /// Compares working grid and starting grid and returns whether there's a value at the
    /// specified coordinate only in the working grid.
    private func onlyWorkingGridHasValue(at coordinate: Coordinate) -> Bool {
        let workingGridHasAValue = containsAValue(at: coordinate, grid: grid)
        let startingGridHasAValue = containsAValue(at: coordinate, grid: startingGrid)
        return workingGridHasAValue && !startingGridHasAValue
    }
    
    private func updateColorGrid(_ coordinateValue: CoordinateValue) {
        guard onlyWorkingGridHasValue(at: coordinateValue.coordinate) else {
            // starting grid
            let coordinateColor = CoordinateColor(coordinate: coordinateValue, color: .black)
            colorGrid.update(with: coordinateColor)
            return
        }
        
        if value(coordinateValue.v, wouldBeInvalidAt: coordinateValue.coordinate) {
            // user has just entered an invalid digit
            let coordinateColor = CoordinateColor(coordinate: coordinateValue, color: .red)
            colorGrid.update(with: coordinateColor)
        } else {
            let coordinateColor = CoordinateColor(coordinate: coordinateValue, color: Color("dynamicBlue"))
            colorGrid.update(with: coordinateColor)
        }
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
    
    private func populateEmptyColorGrid(_ grid: [CoordinateValue]) {
        grid.forEach { coordinateValue in
            let coordinateColor = CoordinateColor(coordinate: coordinateValue, color: .black)
            colorGrid.update(with: coordinateColor)
        }
    }
}
