//
//  ChatResponse.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import Foundation

struct ChatResponse: Codable {
    
    let id: String
    let choices: [ChatCompletionChoice]
    let created: Int
    let model: String
    let object: String
    let systemFingerprint: String?
    
    /// For generating sudoku boards, we expect a structured grid output.
    var coordinateValues: [CoordinateValue]? {
        guard let content = choices.first?.message.content else {
            return nil
        }

        let jsonData = Data(content.utf8)
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]

        guard let coordinateValuesData = jsonObject?["coordinate_values"] as? [[String: Any]] else {
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let coordinateValues = try? decoder.decode([CoordinateValue].self, from: JSONSerialization.data(withJSONObject: coordinateValuesData))

        return coordinateValues
    }
}

struct ChatCompletionChoice: Codable {
    
    let finishReason: String
    let index: Int
    let message: ChatCompletionMessage
}

struct ChatCompletionMessage: Codable {
    
    let content: String?
    let role: String
}

