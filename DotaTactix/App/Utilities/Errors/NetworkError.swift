//
//  APIError.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import Foundation

enum NetworkError: Error {
  case badUrl
  case badResponse
  case badStatus
  case failedToDecode
  case noAPIkey
}

extension NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .badUrl:
      return "Bad URL: use a different URL"
    case .badResponse:
      return "Bad Response: received bad response"
    case .badStatus:
      return "Bad Status: status code is not 200"
    case .failedToDecode:
      return "Failed to decode JSON"
    case .noAPIkey:
      return "Can't find API Key"
    }
  }
}
