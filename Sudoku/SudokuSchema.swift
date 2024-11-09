
import Foundation

struct SudokuSchema {
    static let schema: [String: Any] = [
        "name": "sudoku_board",
        "schema": [
            "type": "object",
            "properties": [
                "coordinate_values": [
                    "type": "array",
                    "description": "An array of cells in the Sudoku board.",
                    "items": [
                        "type": "object",
                        "properties": [
                            "r": [
                                "type": "number",
                                "description": "The row index relative to the square within the Sudoku board it's in, must be an integer between 0 and 2."
                            ],
                            "c": [
                                "type": "number",
                                "description": "The column index relative to the square within the Sudoku board it's in, must be an integer between 0 and 2."
                            ],
                            "s": [
                                "type": "number",
                                "description": "The square index of the Sudoku board, must be an integer between 0 and 8. A square is a 3 by 3 subgrid that contains all of the digits from 1 to 9. The index 0 maps to the top left subgrid, 1 maps to the top middle, 2 maps to the top right, 3 maps to the middle left, 4 maps to the center, 5 maps to the middle right, 6 maps to the bottom left, 7 maps to the bottom middle, and 8 maps to the bottom right subgrid."
                            ],
                            "v": [
                                "type": "number",
                                "description": "The value in the Sudoku coordinate, must be an integer between 1 and 9."
                            ]
                        ],
                        "required": ["r", "c", "s", "v"],
                        "additionalProperties": false
                    ]
                ]
            ],
            "required": ["coordinate_values"],
            "additionalProperties": false
        ],
        "strict": true
    ]
}
