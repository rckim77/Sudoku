//
//  API.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import Foundation

struct API {
    
    enum APIError: Error {
        case invalidURL
        case invalidStringGrid
        case messageNotAString
    }

    // DO NOT COMMIT THIS TOKEN
    static let chatGPTKey = ""
    
    /// Helper method for POST requests sending JSON with basic error handling
    static func postURLRequest(url: String, requestBody: [String: Any]) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }

    static func getHint(grid: [CoordinateValue]) async throws -> ChatResponse? {
        var prompt: [[String: String]] = []
        let stringGrid = GridFactory.stringGridFor(grid: grid)
        let content = """
            You are a sudoku assistant. Provide a single succinct hint specific to the following sudoku puzzle 
            without giving away too much. The sudoku will be represented as an array of arrays where each array
            represents a square. There are 9 squares in the sudoku. Each square contains 9 integer values. If there
            is a 0 in the square, that means it is empty and we need to input a valid integer 1 through 9. The
            first square in the array is the top left square of the sudoku. The second square is the top center
            square. The third square is the top right square. The fourth square is the middle left square. The
            fifth square is the middle center square. The sixth square is the middle right square. The seventh
            square is the bottom left square. The eighth square is the bottom center square. The ninth square is
            the bottom right square. Here is the sudoku:\n \(stringGrid)
        """

        prompt.append(["role": "system", "content": content])
        
        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": prompt
        ]
        
        var urlRequest = try postURLRequest(url: "https://api.openai.com/v1/chat/completions", requestBody: requestBody)

        urlRequest.addValue("Bearer \(API.chatGPTKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let chatResponse = try decoder.decode(ChatResponse.self, from: data)

        return chatResponse
    }

    static func generateSudokuBoard(difficulty: Difficulty.Level) async throws -> [CoordinateValue] {
        let content = """
            You are a Sudoku puzzle generator for people to solve. Generate a classic \(difficulty.rawValue.lowercased()) Sudoku starting board with a single solution given the JSON schema provided as an array of coordinate values. The objective is to fill a 9 by 9 grid with digits so that each column, each row, and each of the nine 3 by 3 subgrids that compose the grid contains all the digits from 1 to 9. For cells that are initially empty, do not return them at all in the array–only return starting coordinate values that populate the board. Ensure that the generated board is valid, solvable, and a suitable difficulty.
        """

        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": content]
            ],
            "response_format": [
                "type": "json_schema",
                "json_schema": SudokuSchema.schema
            ]
        ]
        
        var urlRequest = try postURLRequest(url: "https://api.openai.com/v1/chat/completions", requestBody: requestBody)
        urlRequest.addValue("Bearer \(API.chatGPTKey)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let chatResponse = try decoder.decode(ChatResponse.self, from: data)
        
        guard let stringGrid = chatResponse.choices.first?.message.content else {
            throw APIError.messageNotAString
        }

        let jsonData = Data(stringGrid.utf8)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        
        guard let coordinateValuesData = jsonObject?["coordinate_values"] as? [[String: Any]] else {
            throw APIError.invalidStringGrid
        }
        
        let coordinateValues = try decoder.decode([CoordinateValue].self, from: JSONSerialization.data(withJSONObject: coordinateValuesData))
        
        return coordinateValues
    }
}
