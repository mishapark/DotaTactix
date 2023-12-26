//
//  GPTAnswer.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-21.
//

import Foundation

struct Tactics: Codable, Identifiable, Equatable {
  let id = UUID()
  let itemBuild: ItemBuild
  let strategy: Strategy

  enum CodingKeys: String, CodingKey {
    case itemBuild = "item_build"
    case strategy
  }

  static func == (lhs: Tactics, rhs: Tactics) -> Bool {
    lhs.id == rhs.id
  }
}

// MARK: - ItemBuild

struct ItemBuild: Codable {
  let startingItems, earlyGame, coreItems, luxuryItems, situationalItems: [String]

  enum CodingKeys: String, CodingKey {
    case startingItems = "starting_items"
    case earlyGame = "early_game"
    case coreItems = "core_items"
    case luxuryItems = "luxury_items"
    case situationalItems = "situational_items"
  }
}

// MARK: - Strategy

struct Strategy: Codable {
  let earlyGame, midGame, lateGame: String

  enum CodingKeys: String, CodingKey {
    case earlyGame = "early_game"
    case midGame = "mid_game"
    case lateGame = "late_game"
  }
}
