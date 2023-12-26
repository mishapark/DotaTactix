//
//  GPTModel.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-21.
//

import Foundation

struct GPTResponse: Codable {
  let id: String
  let created: Int
  let choices: [Choice]
  let usage: Usage

  enum CodingKeys: String, CodingKey {
    case id, created, choices, usage
  }
}

// MARK: - Choice

struct Choice: Codable {
  let index: Int
  let message: Message
  let finishReason: String

  enum CodingKeys: String, CodingKey {
    case index, message
    case finishReason = "finish_reason"
  }
}

// MARK: - Message

struct Message: Codable {
  let role, content: String
}

// MARK: - Usage

struct Usage: Codable {
  let promptTokens, completionTokens, totalTokens: Int

  enum CodingKeys: String, CodingKey {
    case promptTokens = "prompt_tokens"
    case completionTokens = "completion_tokens"
    case totalTokens = "total_tokens"
  }
}
