//
//  OpenAIManager.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-21.
//

import Foundation

class OpenAIManager {
  static let shared = OpenAIManager()
  private init() {}

  func getTactics(for hero: String, lane: String?, allies: [String]?, enemies: [String]?) async throws -> Tactics {
    let message = buildMessage(hero: hero, lane: lane, allies: allies, enemies: enemies)

    let urlRequest = try await buildUrlRequest(with: message)

    let data = try await NetworkManager.shared.fetchWithURLRequest(urlRequest)
    let gptResponse = try JSONDecoder().decode(GPTResponse.self, from: data)

    guard gptResponse.choices[0].finishReason == "stop" else {
      throw NetworkError.badResponse
    }
    guard let gptAnswer = gptResponse.choices[0].message.content.data(using: .utf8) else {
      throw NetworkError.failedToDecode
    }

    let tactics = try JSONDecoder().decode(Tactics.self, from: gptAnswer)

    return tactics
  }

  func buildUrlRequest(with message: String) async throws -> URLRequest {
    guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
      throw NetworkError.badUrl
    }
    let apiKey = try getApiKey()

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.allHTTPHeaderFields = [
      "Authorization": "Bearer \(apiKey)",
      "Content-Type": "application/json"
    ]

    let systemMessage = GPTMessage(
      role: "system",
      content: "You are a helpful assistant designed to output JSON."
    )
    let userMessage = GPTMessage(
      role: "user",
      content: message
    )
    let payload = GPTPayload(
      messages: [systemMessage, userMessage],
      model: "gpt-3.5-turbo-1106",
      responseFormat: GPTType(type: "json_object")
    )
    let jsonData = try JSONEncoder().encode(payload)
    urlRequest.httpBody = jsonData

    return urlRequest
  }

  func getApiKey() throws -> String {
    guard let filePath = Bundle.main.path(forResource: "OpenAI-Info", ofType: "plist") else {
      throw NetworkError.noAPIkey
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      throw NetworkError.noAPIkey
    }
    return value
  }

  func buildMessage(hero: String, lane: String?, allies: [String]?, enemies: [String]?) -> String {
    return """
    dota 2 items, strategy for \(hero) on \(lane ?? "any") lane
    allies: \(allies?.joined(separator: ", ") ?? "")
    enemies: \(enemies?.joined(separator: ", ") ?? "")
    {
      "item_build": {
        "starting_items": [String]
        "early_game": [String]
        "core_items": [String]
        "luxury_items": [String]
        "situational_items": [String]
      },
      "strategy": {
        "early_game": String,
        "mid_game": String,
        "late_game": String
      }
    }
    """
  }
}

struct GPTPayload: Encodable {
  let messages: [GPTMessage]
  let model: String
  let responseFormat: GPTType

  enum CodingKeys: String, CodingKey {
    case messages, model
    case responseFormat = "response_format"
  }
}

struct GPTMessage: Encodable {
  let role: String
  let content: String
}

struct GPTType: Encodable {
  let type: String
}
