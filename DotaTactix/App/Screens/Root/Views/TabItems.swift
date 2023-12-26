//
//  TabsEnum.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import Foundation

enum TabItems: Int, CaseIterable {
  case home = 0
  case news
  case glossary

  var title: String {
    switch self {
    case .home:
      return "Home"
    case .news:
      return "News"
    case .glossary:
      return "Glossary"
    }
  }

  var iconName: String {
    switch self {
    case .home:
      return "dota"
    case .news:
      return "news"
    case .glossary:
      return "heroes"
    }
  }
}
