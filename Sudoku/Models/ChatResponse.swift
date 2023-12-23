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

