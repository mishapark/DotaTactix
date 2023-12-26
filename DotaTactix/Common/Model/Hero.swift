//
//  Hero.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

var heroRoles: [Int: String] = [
  0: "Carry",
  1: "Escape",
  2: "Nuker",
  3: "Initiator",
  4: "Durable",
  5: "Disabler",
  6: "Jungler",
  7: "Support",
  8: "Pusher"
]

struct Hero: Identifiable, Hashable {
  let id: Int
  let abilities: [Ability]
  let talents: [Talent]
  let name: String
  let shortName: String
  let displayName: String
  let image: String
  let icon: String
  let verticalImage: String
  let bio: String
  let shortBio: String
  let complexity: Int
  let roles: [String]
  let attackType: AttackType
  let startingArmor: Double
  let startingMagicArmor: Int
  let startingDamageMin: Int
  let startingDamageMax: Int
  let attackRate: Double
  let attackRange: Int
  let attributePrimary: AttributePrimary
  let strengthBase: Int
  let strengthGain: Double
  let intelligenceBase: Int
  let intelligenceGain: Double
  let agilityBase: Int
  let agilityGain: Double
  let hpRegen: Double
  let mpRegen: Double
  let moveSpeed: Int
  let moveTurnRate: Double
  let visionDaytimeRange: Int
  let visionNighttimeRange: Int

  init(from hero: HeroData, abilities: [Ability], talents: [Talent]) {
    id = hero.id
    self.abilities = abilities
    self.talents = talents
    name = hero.name
    shortName = hero.shortName
    displayName = hero.displayName ?? ""
    image = "https://api.opendota.com/apps/dota2/images/dota_react/heroes/\(shortName).png?"
    icon = "https://api.opendota.com/apps/dota2/images/dota_react/heroes/icons/\(shortName).png?"
    verticalImage = "https://cdn.dota2.com/apps/dota2/images/heroes/\(shortName)_vert.jpg"
    bio = hero.language?.bio ?? ""
    shortBio = hero.language?.hype ?? ""
    complexity = hero.stat.complexity ?? 0
    roles = hero.roles?.compactMap { heroRoles[$0.roleID] } ?? []
    attackType = hero.stat.attackType ?? .melee
    startingArmor = hero.stat.startingArmor ?? 0
    startingMagicArmor = hero.stat.startingMagicArmor ?? 0
    startingDamageMin = hero.stat.startingDamageMin ?? 0
    startingDamageMax = hero.stat.startingDamageMax ?? 0
    attackRate = hero.stat.attackRate ?? 0
    attackRange = hero.stat.attackRange ?? 0
    attributePrimary = hero.stat.attributePrimary ?? .all
    strengthBase = hero.stat.strengthBase ?? 0
    strengthGain = hero.stat.strengthGain ?? 0
    intelligenceBase = hero.stat.intelligenceBase ?? 0
    intelligenceGain = hero.stat.intelligenceGain ?? 0
    agilityBase = hero.stat.agilityBase ?? 0
    agilityGain = hero.stat.agilityGain ?? 0
    hpRegen = hero.stat.hpRegen ?? 0
    mpRegen = hero.stat.mpRegen ?? 0
    moveSpeed = hero.stat.moveSpeed ?? 0
    moveTurnRate = hero.stat.moveTurnRate ?? 0
    visionDaytimeRange = hero.stat.visionDaytimeRange ?? 0
    visionNighttimeRange = hero.stat.visionNighttimeRange ?? 0
  }

  static func == (lhs: Hero, rhs: Hero) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

struct Ability {
  let slot: Int
  let ability: AbilityData
}

struct Talent {
  let slot: Int
  let ability: AbilityData
}
