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
        case invalidURL
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

    static func getHint(grid: [CoordinateValue], difficulty: Difficulty.Level) async throws -> String? {
        let openAIService = AIProxy.openAIService(
            partialKey: "v2|c7d0ff39|qrIzn_OLLetLdcWN",
            serviceURL: "https://api.aiproxy.pro/c160196f/657d65d2"
        )

        let stringGrid = GridFactory.stringGridFor(grid: grid)
        let difficultyString = difficulty.rawValue.lowercased()
        let content = """
            You are a sudoku expert and assistant. Provide a single succinct hint specific to the following sudoku 
            puzzle without giving away too much. The sudoku will be represented as an array of arrays where each 
            array represents a 3 x 3 subgrid in a specific order. There are 9 subgrids in the sudoku board. Each 
            solved subgrid contains the numbers 1 to 9 only once each. The overall sudoku board must follow standard 
            sudoku rules. If there is a 0 in the input subgrid, that means that cell is unsolved. 
        
            The first array in the input board is the top leftmost subgrid of the sudoku board. The second array 
            is the top center subgrid. The third array is the top rightmost subgrid. The fourth array is the middle 
            row leftmost subgrid. The fifth array is the middle row center subgrid. The sixth array is the middle row 
            rightmost subgrid. The seventh array represents is the bottom leftmost subgrid. The eighth array is the bottom 
            center subgrid. The ninth array is the bottom rightmost subgrid. 
        
            When explaining the hint, do not use certain words as described earlier. Instead of subgrid, say square. Do not
            refer to rows, columns, and subgrids by their indices but rather in more user-friendly terms that are more visual
            and intuitive (e.g., top leftmost square has a 1–the cell next to it can only be two possible numbers). When
            describing possible integers within a cell, call them candidates.
        
            Make sure the hint is appropriate for the difficulty of the sudoku board. This sudoku has a difficulty level of
            \(difficultyString). The harder the difficulty, the less helpful the hint should be. The easier the sudoku, the more
            obvious the hint should be. Make sure the hint helps the user problem solve. Do not give overly obvious hints (e.g., 
            this cell is a 4). Use terms that a sudoku player would understand (e.g., X-Wing, naked pairs, hidden pairs).
        
            Make sure the hint is succinct. It should not be more than a few sentences.

            Here is the sudoku:\n \(stringGrid)
        """
        
        do {
            let requestBody = OpenAIChatCompletionRequestBody(model: "gpt-4o-mini", messages: [.system(content: .text(content))])
            let response = try await openAIService.chatCompletionRequest(body: requestBody)
            return response.choices.first?.message.content
        } catch AIProxyError.unsuccessfulRequest(statusCode: let statusCode, responseBody: let responseBody) {
            print("Received \(statusCode) status code with response body: \(responseBody)")
            return nil
        } catch {
            print("Could not create OpenAI chat completion: \(error.localizedDescription)")
            return nil
        }
    }
}
