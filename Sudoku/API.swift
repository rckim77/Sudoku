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

    static func getHint(grid: [CoordinateValue]) async throws -> OpenAIChatCompletionResponseBody? {
        let openAIService = AIProxy.openAIService(
            partialKey: "v2|c7d0ff39|qrIzn_OLLetLdcWN",
            serviceURL: "https://api.aiproxy.pro/c160196f/657d65d2"
        )

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
        
        do {
            let requestBody = OpenAIChatCompletionRequestBody(model: "gpt-4o-mini", messages: [.system(content: .text(content))])
            let response = try await openAIService.chatCompletionRequest(body: requestBody)
            return response
        } catch AIProxyError.unsuccessfulRequest(statusCode: let statusCode, responseBody: let responseBody) {
            print("Received \(statusCode) status code with response body: \(responseBody)")
            return nil
        } catch {
            print("Could not create OpenAI chat completion: \(error.localizedDescription)")
            return nil
        }
    }
}
