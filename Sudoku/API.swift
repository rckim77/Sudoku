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

    static func getHint(grid: [CoordinateValue]) async throws -> ChatResponse? {
        
        // set to your ChatGPT API secret key (otherwise hint functionality won't work)
        let bearerToken = ""
        var prompt: [[String: String]] = []
        let stringGrid = GridFactory.stringGridFor(grid: grid)
        let content = "Provide a helpful clue specific to the following sudoku puzzle:\n \(stringGrid)"

        prompt.append(["role": "user", "content": content])
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": prompt
        ]
        
        var urlRequest = try postURLRequest(url: "https://api.openai.com/v1/chat/completions", requestBody: requestBody)

        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let chatResponse = try decoder.decode(ChatResponse.self, from: data)

        return chatResponse
    }
}
