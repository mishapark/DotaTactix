//
//  Item.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-19.
//

import Foundation

struct Item: Codable, Identifiable {
  var name: String?
  let hint: [String]?
  let id: Int
  let img: String
  let dname: String?
  let qual: Quality?
  let cost: Int?
  let notes: String
  let attrib: [JSONAny]
  let manacost, cooldown: ItemCD
  let lore: String
  let components: [String]?
  let created: Bool
  let charges: ItemCD?

  enum CodingKeys: String, CodingKey {
    case hint
    case id
    case img
    case dname
    case qual
    case cost
    case notes
    case attrib
    case manacost = "mc"
    case cooldown = "cd"
    case lore
    case components
    case created
    case charges
  }
}

enum ItemCD: Codable {
  case bool(Bool)
  case integer(Int)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode(Bool.self) {
      self = .bool(x)
      return
    }
    if let x = try? container.decode(Int.self) {
      self = .integer(x)
      return
    }
    throw DecodingError.typeMismatch(
      CD.self,
      DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Wrong type for CD"
      )
    )
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .bool(let x):
      try container.encode(x)
    case .integer(let x):
      try container.encode(x)
    }
  }
}

enum Quality: String, Codable, CaseIterable {
  case consumable
  case common
  case component
  case rare
  case artifact
  case epic
  case secretShop = "secret_shop"
}
