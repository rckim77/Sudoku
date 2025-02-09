//
//  API.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import Foundation
import AIProxy

struct API {
    
    enum APIError: Error {
        case invalidURL, quotaExceeded
    }
    
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

    static func getHint(grid: [CoordinateValue], difficulty: Difficulty.Level) async throws -> Hint? {
        if let singleHint = SudokuSolver.findSingles(grid).first {
            return singleHint
        }
        
        let openAIService = AIProxy.openAIService(
            partialKey: "v2|c7d0ff39|qrIzn_OLLetLdcWN",
            serviceURL: "https://api.aiproxy.pro/c160196f/657d65d2"
        )

        let stringGrid = GridFactory.stringGridFor(grid: grid)
        let difficultyString = difficulty.rawValue.lowercased()
        
        let content = """
            You are a Sudoku assistant. The following is a Sudoku puzzle of \(difficultyString) difficulty.
            Empty cells are marked as 0. The grid is represented as 9 arrays, each representing a 3x3 square
            from left to right, top to bottom:

            \(stringGrid)

            Provide one specific, accurate hint following the following rules:
            1. For easy difficulty: Look for obvious patterns or scanning techniques
            2. For medium difficulty: Suggest looking for hidden pairs or pointing pairs
            3. For hard difficulty: Guide towards advanced techniques like X-Wings or XY-Wings
            4. Always verify your hint is valid and doesn't violate Sudoku rules
            5. Use at most 2 sentences and never give direct solutions
            6. Use natural language when referring to positions (e.g., 'third row from top')
        """
        
        do {
            let requestBody = OpenAIChatCompletionRequestBody(
                model: "gpt-4o-mini",
                messages: [.system(content: .text(content))]
            )
            let response = try await openAIService.chatCompletionRequest(body: requestBody)
            let hint = Hint(coordinate: nil, hintType: .open, overrideDescription: response.choices.first?.message.content)
            return hint
        } catch AIProxyError.unsuccessfulRequest(statusCode: let statusCode, responseBody: let responseBody) {
            print("Received \(statusCode) status code with response body: \(responseBody)")
            if statusCode == 429 {
                throw APIError.quotaExceeded
            }
            return nil
        } catch {
            print("Could not create OpenAI chat completion: \(error.localizedDescription)")
            return nil
        }
    }
}
