//
//  API.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import Foundation

struct API {
    static func getHint(grid: [CoordinateValue]) async throws -> ChatResponse? {
        
        // set to your ChatGPT API secret key (otherwise hint functionality won't work)
        let bearerToken = ""

        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        var prompt: [[String: String]] = []
        let stringGrid = GridFactory.stringGridFor(grid: grid)
        let content = "Provide a helpful clue specific to the following sudoku puzzle:\n \(stringGrid)"

        prompt.append(["role": "user", "content": content])
        
        let jsonbody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": prompt
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonbody)

        urlRequest.httpBody = jsonData
        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let chatResponse = try decoder.decode(ChatResponse.self, from: data)

        return chatResponse
    }
}
