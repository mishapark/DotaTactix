//
//  News.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-18.
//

import Foundation

struct News: Codable {
  let appnews: Appnews
}

// MARK: - Appnews

struct Appnews: Codable {
  let newsitems: [NewsItem]
}

// MARK: - Newsitem

struct NewsItem: Codable {
  let gid, title: String
  let url: String
  let author, contents: String
  let feedlabel: String
  let date: Int
  let tags: [String]?

  enum CodingKeys: String, CodingKey {
    case gid, title, url
    case author, contents, feedlabel, date
    case tags
  }
}
