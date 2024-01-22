//
//  DataManager.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import Foundation

class HeroManager: ObservableObject {
  static let shared = HeroManager()
  private init() {}

  @Published var heroes: [Hero] = []

  func fetchHeroes() async throws {
    let heroesDictionary: [String: HeroData] = try await DataManager.shared.fetchFromFileOrURL(
      fileName: "heroes.json",
      url: StratzEndpoints.heroes.rawValue
    )
    let heroesWithAbilities = try await addAbilitiesToHeroes(
      heroes: Array(heroesDictionary.values),
      isRefreshing: false
    )

    heroes = sortHeroes(heroesWithAbilities)
  }

  func refreshHeroes() async throws {
    let heroesData = try await NetworkManager.shared.fetchFromURL(StratzEndpoints.heroes.rawValue)
    let heroesDictionary = try JSONDecoder().decode([String: HeroData].self, from: heroesData)

    let heroesWithAbilities = try await addAbilitiesToHeroes(heroes: Array(heroesDictionary.values), isRefreshing: true)

    heroes = sortHeroes(heroesWithAbilities)
  }

  // MARK: - Private methods

  private func sortHeroes(_ heroes: [Hero]) -> [Hero] {
    heroes.filter { !$0.displayName.isEmpty }.sorted { $0.displayName < $1.displayName }
  }

  private func addAbilitiesToHeroes(heroes: [HeroData], isRefreshing: Bool) async throws -> [Hero] {
    let abilitiesDictionary: [Int: AbilityData] = isRefreshing
      ? try await refreshAbilities()
      : try await fetchAbilities()

    let heroes = heroes.map { hero -> Hero in
      let abilities = hero.abilities?.compactMap { heroAbility -> Ability? in
        if let abilityFromDictionary = abilitiesDictionary[heroAbility.abilityID] {
          return Ability(slot: heroAbility.slot, ability: abilityFromDictionary)
        }
        return nil
      }
      let talents = hero.talents?.compactMap { heroTalent -> Talent? in
        if let talentFromDictionary = abilitiesDictionary[heroTalent.abilityID] {
          return Talent(slot: heroTalent.slot, ability: talentFromDictionary)
        }
        return nil
      }

      return Hero(
        from: hero,
        abilities: abilities?.filter { $0.ability.dname != "" } ?? [],
        talents: talents?.filter { $0.ability.dname != "" } ?? []
      )
    }

    return heroes
  }

  private func fetchAbilities() async throws -> [Int: AbilityData] {
    let abilityDictionary: [String: String] = try await DataManager.shared.fetchFromFileOrURL(
      fileName: "abilityIDs.json",
      url: OpenDotaEndpoints.abilityIDs.rawValue
    )
    let abilities: [String: AbilityData] = try await DataManager.shared.fetchFromFileOrURL(
      fileName: "abilities.json",
      url: OpenDotaEndpoints.abilities.rawValue
    )

    var result: [Int: AbilityData] = [:]

    for (id, ability) in abilityDictionary {
      if let id = Int(id) {
        result[id] = abilities[ability]
        result[id]?.name = ability
      }
    }

    return result
  }

  private func refreshAbilities() async throws -> [Int: AbilityData] {
    let abilityIDsData = try await NetworkManager.shared.fetchFromURL(OpenDotaEndpoints.abilityIDs.rawValue)
    let abilityDictionary = try JSONDecoder().decode([String: String].self, from: abilityIDsData)

    let abilitiesData = try await NetworkManager.shared.fetchFromURL(OpenDotaEndpoints.abilities.rawValue)
    let abilities = try JSONDecoder().decode([String: AbilityData].self, from: abilitiesData)

    var result: [Int: AbilityData] = [:]

    for (id, ability) in abilityDictionary {
      if let id = Int(id) {
        result[id] = abilities[ability]
      }
    }

    return result
  }
}
