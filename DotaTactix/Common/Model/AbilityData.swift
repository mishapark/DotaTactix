//
//  AbilityData.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import Foundation

// swiftlint:disable all

struct AbilityData: Codable {
  let dname: String?
  let attrib: [Attrib]?
  let img: String?
  let behavior: BehaviorUnion?
  let targetTeam: TargetTeamUnion?
  let dmgType: DmgTypeUnion?
  let bkbpierce: BkbpierceUnion?
  let desc, lore: String?
  let manacost, cooldown: CD?
  let dispellable: BkbpierceUnion?
  let targetType: TargetTypeUnion?
  let dmg: CD?

  enum CodingKeys: String, CodingKey {
    case dname, attrib, img, behavior
    case targetTeam = "target_team"
    case dmgType = "dmg_type"
    case bkbpierce, desc, lore, dispellable
    case manacost = "mc"
    case cooldown = "cd"
    case targetType = "target_type"
    case dmg
  }
}

// MARK: - Attrib

struct Attrib: Codable {
  let key, header: String
  let value: CD
  let generated: Bool?
  let footer: String?
}

enum CD: Codable {
  case string(String)
  case stringArray([String])

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([String].self) {
      self = .stringArray(x)
      return
    }
    if let x = try? container.decode(String.self) {
      self = .string(x)
      return
    }
    throw DecodingError.typeMismatch(CD.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CD"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .string(let x):
      try container.encode(x)
    case .stringArray(let x):
      try container.encode(x)
    }
  }
}

enum BehaviorUnion: Codable {
  case enumArray([BehaviorElement])
  case enumeration(BehaviorElement)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([BehaviorElement].self) {
      self = .enumArray(x)
      return
    }
    if let x = try? container.decode(BehaviorElement.self) {
      self = .enumeration(x)
      return
    }
    throw DecodingError.typeMismatch(BehaviorUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BehaviorUnion"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .enumArray(let x):
      try container.encode(x)
    case .enumeration(let x):
      try container.encode(x)
    }
  }
}

enum BehaviorElement: String, Codable {
  case aoe = "AOE"
  case attackModifier = "Attack Modifier"
  case autocast = "Autocast"
  case channeled = "Channeled"
  case hidden = "Hidden"
  case instantCast = "Instant Cast"
  case noTarget = "No Target"
  case passive = "Passive"
  case pointTarget = "Point Target"
  case unitTarget = "Unit Target"
}

enum BkbpierceUnion: Codable {
  case anythingArray([JSONAny])
  case enumeration(BkbpierceEnum)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([JSONAny].self) {
      self = .anythingArray(x)
      return
    }
    if let x = try? container.decode(BkbpierceEnum.self) {
      self = .enumeration(x)
      return
    }
    throw DecodingError.typeMismatch(BkbpierceUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BkbpierceUnion"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .anythingArray(let x):
      try container.encode(x)
    case .enumeration(let x):
      try container.encode(x)
    }
  }
}

enum BkbpierceEnum: String, Codable {
  case no = "No"
  case yes = "Yes"
}

enum DmgTypeUnion: Codable {
  case anythingArray([JSONAny])
  case enumeration(DmgTypeEnum)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([JSONAny].self) {
      self = .anythingArray(x)
      return
    }
    if let x = try? container.decode(DmgTypeEnum.self) {
      self = .enumeration(x)
      return
    }
    throw DecodingError.typeMismatch(DmgTypeUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DmgTypeUnion"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .anythingArray(let x):
      try container.encode(x)
    case .enumeration(let x):
      try container.encode(x)
    }
  }
}

enum DmgTypeEnum: String, Codable {
  case magical = "Magical"
  case physical = "Physical"
  case pure = "Pure"
}

enum TargetTeamUnion: Codable {
  case enumArray([TargetTeamElement])
  case enumeration(TargetTeamElement)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([TargetTeamElement].self) {
      self = .enumArray(x)
      return
    }
    if let x = try? container.decode(TargetTeamElement.self) {
      self = .enumeration(x)
      return
    }
    throw DecodingError.typeMismatch(TargetTeamUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TargetTeamUnion"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .enumArray(let x):
      try container.encode(x)
    case .enumeration(let x):
      try container.encode(x)
    }
  }
}

enum TargetTeamElement: String, Codable {
  case both = "Both"
  case enemy = "Enemy"
  case friendly = "Friendly"
}

enum TargetTypeUnion: Codable {
  case enumArray([TargetTypeElement])
  case enumeration(TargetTypeElement)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([TargetTypeElement].self) {
      self = .enumArray(x)
      return
    }
    if let x = try? container.decode(TargetTypeElement.self) {
      self = .enumeration(x)
      return
    }
    throw DecodingError.typeMismatch(TargetTypeUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TargetTypeUnion"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .enumArray(let x):
      try container.encode(x)
    case .enumeration(let x):
      try container.encode(x)
    }
  }
}

enum TargetTypeElement: String, Codable {
  case basic = "Basic"
  case building = "Building"
  case hero = "Hero"
  case tree = "Tree"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }

  func hash(into hasher: inout Hasher) {
    // Use a unique hash value for JSONNull
    hasher.combine(0)
  }

  public init() {}

  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}

class JSONCodingKey: CodingKey {
  let key: String

  required init?(intValue: Int) {
    return nil
  }

  required init?(stringValue: String) {
    self.key = stringValue
  }

  var intValue: Int? {
    return nil
  }

  var stringValue: String {
    return key
  }
}

class JSONAny: Codable {
  let value: Any

  static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
    let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
    return DecodingError.typeMismatch(JSONAny.self, context)
  }

  static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
    let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
    return EncodingError.invalidValue(value, context)
  }

  static func decode(from container: SingleValueDecodingContainer) throws -> Any {
    if let value = try? container.decode(Bool.self) {
      return value
    }
    if let value = try? container.decode(Int64.self) {
      return value
    }
    if let value = try? container.decode(Double.self) {
      return value
    }
    if let value = try? container.decode(String.self) {
      return value
    }
    if container.decodeNil() {
      return JSONNull()
    }
    throw decodingError(forCodingPath: container.codingPath)
  }

  static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
    if let value = try? container.decode(Bool.self) {
      return value
    }
    if let value = try? container.decode(Int64.self) {
      return value
    }
    if let value = try? container.decode(Double.self) {
      return value
    }
    if let value = try? container.decode(String.self) {
      return value
    }
    if let value = try? container.decodeNil() {
      if value {
        return JSONNull()
      }
    }
    if var container = try? container.nestedUnkeyedContainer() {
      return try decodeArray(from: &container)
    }
    if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
      return try decodeDictionary(from: &container)
    }
    throw decodingError(forCodingPath: container.codingPath)
  }

  static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
    if let value = try? container.decode(Bool.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(Int64.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(Double.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(String.self, forKey: key) {
      return value
    }
    if let value = try? container.decodeNil(forKey: key) {
      if value {
        return JSONNull()
      }
    }
    if var container = try? container.nestedUnkeyedContainer(forKey: key) {
      return try decodeArray(from: &container)
    }
    if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
      return try decodeDictionary(from: &container)
    }
    throw decodingError(forCodingPath: container.codingPath)
  }

  static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
    var arr: [Any] = []
    while !container.isAtEnd {
      let value = try decode(from: &container)
      arr.append(value)
    }
    return arr
  }

  static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
    var dict = [String: Any]()
    for key in container.allKeys {
      let value = try decode(from: &container, forKey: key)
      dict[key.stringValue] = value
    }
    return dict
  }

  static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
    for value in array {
      if let value = value as? Bool {
        try container.encode(value)
      } else if let value = value as? Int64 {
        try container.encode(value)
      } else if let value = value as? Double {
        try container.encode(value)
      } else if let value = value as? String {
        try container.encode(value)
      } else if value is JSONNull {
        try container.encodeNil()
      } else if let value = value as? [Any] {
        var container = container.nestedUnkeyedContainer()
        try encode(to: &container, array: value)
      } else if let value = value as? [String: Any] {
        var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
        try encode(to: &container, dictionary: value)
      } else {
        throw encodingError(forValue: value, codingPath: container.codingPath)
      }
    }
  }

  static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
    for (key, value) in dictionary {
      let key = JSONCodingKey(stringValue: key)!
      if let value = value as? Bool {
        try container.encode(value, forKey: key)
      } else if let value = value as? Int64 {
        try container.encode(value, forKey: key)
      } else if let value = value as? Double {
        try container.encode(value, forKey: key)
      } else if let value = value as? String {
        try container.encode(value, forKey: key)
      } else if value is JSONNull {
        try container.encodeNil(forKey: key)
      } else if let value = value as? [Any] {
        var container = container.nestedUnkeyedContainer(forKey: key)
        try encode(to: &container, array: value)
      } else if let value = value as? [String: Any] {
        var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
        try encode(to: &container, dictionary: value)
      } else {
        throw encodingError(forValue: value, codingPath: container.codingPath)
      }
    }
  }

  static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
    if let value = value as? Bool {
      try container.encode(value)
    } else if let value = value as? Int64 {
      try container.encode(value)
    } else if let value = value as? Double {
      try container.encode(value)
    } else if let value = value as? String {
      try container.encode(value)
    } else if value is JSONNull {
      try container.encodeNil()
    } else {
      throw encodingError(forValue: value, codingPath: container.codingPath)
    }
  }

  public required init(from decoder: Decoder) throws {
    if var arrayContainer = try? decoder.unkeyedContainer() {
      self.value = try JSONAny.decodeArray(from: &arrayContainer)
    } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
      self.value = try JSONAny.decodeDictionary(from: &container)
    } else {
      let container = try decoder.singleValueContainer()
      self.value = try JSONAny.decode(from: container)
    }
  }

  public func encode(to encoder: Encoder) throws {
    if let arr = value as? [Any] {
      var container = encoder.unkeyedContainer()
      try JSONAny.encode(to: &container, array: arr)
    } else if let dict = value as? [String: Any] {
      var container = encoder.container(keyedBy: JSONCodingKey.self)
      try JSONAny.encode(to: &container, dictionary: dict)
    } else {
      var container = encoder.singleValueContainer()
      try JSONAny.encode(to: &container, value: value)
    }
  }
}

// swiftlint: enable all
