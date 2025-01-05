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
            You are a Sudoku assistant. The following is a Sudoku puzzle of \(difficultyString) difficulty.
            Empty cells are marked as 0. The grid is represented as 9 arrays, each representing a 3x3 block 
            from left to right, top to bottom:

            \(stringGrid)

            Provide one specific, accurate hint that:
            1. For easy: Focus on single candidates or obvious patterns
            2. For medium: Look for hidden pairs or pointing pairs
            3. For hard: Suggest advanced techniques like X-Wings or XY-Wings
            4. Always verify numbers mentioned in your hint are valid in their stated positions. Double-check 
               that suggested numbers to place in empty cells do not already have a digit there in the input 
               grid. A hint is valid if it does not violate standard Sudoku rules.
            5. Use at most 2 sentences
            6. Never give away direct solutions
            7. Use terminology that is appropriate when helping a human and not a computer. When referring
               to rows and columns, make it clear which ones (e.g., fourth row from the top). Refer to 0 as
               an empty cell.
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
