//
//  NewsManager.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-18.
//

import Foundation

class NewsManager {
  func fetchNews(count: Int) async throws -> [NewsItem] {
    let newsData = try await NetworkManager.shared.fetchFromURL(SteamAPI.newsEndpoint(count: count))
    let news = try JSONDecoder().decode(News.self, from: newsData).appnews.newsitems

    return news
  }
}
