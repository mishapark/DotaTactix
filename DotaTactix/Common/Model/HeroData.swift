//
//  HeroData.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import Foundation

struct HeroData: Codable {
  let id: Int
  let name: String
  let displayName: String?
  let shortName: String
  let abilities: [HeroAbilityData]?
  let roles: [Role]?
  let talents: [TalentData]?
  let stat: StatData
  let language: Language?
}

// MARK: - Ability

struct HeroAbilityData: Codable {
  let slot, abilityID: Int

  enum CodingKeys: String, CodingKey {
    case slot
    case abilityID = "abilityId"
  }
}

// MARK: - Language

struct Language: Codable {
  let bio, hype: String

  enum CodingKeys: String, CodingKey {
    case bio, hype
  }
}

// MARK: - Role

struct Role: Codable {
  let roleID: Int

  enum CodingKeys: String, CodingKey {
    case roleID = "roleId"
  }
}

// MARK: - Stat

struct StatData: Codable {
  let attackType: AttackType?
  let startingArmor: Double?
  let startingMagicArmor, startingDamageMin, startingDamageMax: Int?
  let attackRate: Double?
  let attackRange: Int?
  let attributePrimary: AttributePrimary?
  let strengthBase: Int?
  let strengthGain: Double?
  let intelligenceBase: Int?
  let intelligenceGain: Double?
  let agilityBase: Int?
  let agilityGain, hpRegen, mpRegen: Double?
  let moveSpeed: Int?
  let moveTurnRate: Double?
  let visionDaytimeRange, visionNighttimeRange, complexity: Int?

  enum CodingKeys: String, CodingKey {
    case attackType, startingArmor, startingMagicArmor, startingDamageMin, startingDamageMax, attackRate, attackRange
    case attributePrimary = "AttributePrimary"
    case strengthBase, strengthGain, intelligenceBase, intelligenceGain, agilityBase, agilityGain, hpRegen, mpRegen
    case moveSpeed, moveTurnRate, visionDaytimeRange, visionNighttimeRange, complexity
  }
}

enum AttackType: String, Codable {
  case melee = "Melee"
  case ranged = "Ranged"
}

enum AttributePrimary: String, Codable, CaseIterable {
  case all
  case agi
  case int
  case str
}

// MARK: - Talent

struct TalentData: Codable {
  let slot, abilityID: Int

  enum CodingKeys: String, CodingKey {
    case slot
    case abilityID = "abilityId"
  }
}
