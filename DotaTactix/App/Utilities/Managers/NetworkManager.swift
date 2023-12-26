//
//  APIService.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()

  func fetchFromURL(_ url: String) async throws -> Data {
    do {
      guard let url = URL(string: url) else {
        throw NetworkError.badUrl
      }

      let request = URLRequest(url: url)

      let (data, response) = try await URLSession.shared.data(for: request)

      guard let response = response as? HTTPURLResponse else {
        throw NetworkError.badResponse
      }

      guard (200 ..< 300).contains(response.statusCode) else {
        throw NetworkError.badStatus
      }

      return data
    } catch {
      throw error
    }
  }

  func fetchWithURLRequest(_ urlRequest: URLRequest) async throws -> Data {
    do {
      let (data, response) = try await URLSession.shared.data(for: urlRequest)

      guard let response = response as? HTTPURLResponse else {
        throw NetworkError.badResponse
      }

      guard (200 ..< 300).contains(response.statusCode) else {
        throw NetworkError.badStatus
      }

      return data
    } catch {
      throw error
    }
  }
}
