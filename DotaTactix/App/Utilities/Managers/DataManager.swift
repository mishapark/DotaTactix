//
//  DataManager.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-18.
//

import Foundation

class DataManager {
  static let shared = DataManager()

  func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }

  func fetchFromFileOrURL<CodableData: Codable>(fileName: String, url: String) async throws -> CodableData {
    let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

    var data: Data?

    if FileManager.default.fileExists(atPath: fileURL.path) {
      data = try Data(contentsOf: fileURL)
    } else {
      let apiData = try await NetworkManager.shared.fetchFromURL(url)
      try apiData.write(to: fileURL)
      data = apiData
    }

    guard let data else {
      throw NetworkError.failedToDecode
    }

    let decodedData = try JSONDecoder().decode(CodableData.self, from: data)
    return decodedData
  }
}
