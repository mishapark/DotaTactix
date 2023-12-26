//
//  HomeViewModel.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-21.
//
import Combine
import SwiftUI

@Observable
class DotaTactixViewModel {
  var currentTactics: Tactics?
  var isLoading = false
  var showAlert = false
  var error = "" {
    didSet {
      showAlert = !error.isEmpty
    }
  }

  private var sortedItemsCancellable: Set<AnyCancellable> = []
  var items: [Item] = []
  var allHeroes: Set<Hero> = Set(HeroManager.shared.heroes)

  init() {
    HeroManager.shared.$heroes
      .sink { [weak self] heroes in
        self?.allHeroes = Set(heroes)
      }
      .store(in: &sortedItemsCancellable)
    ItemManager.shared.$items
      .sink { [weak self] sortedItems in
        self?.items = sortedItems
      }
      .store(in: &sortedItemsCancellable)
  }

  var presentHeroPopup = false
  var presentAlliesPopup = false
  var presentEnemiesPopup = false
  var popupHeroes: [Hero] = []

  var selectedLane = "Mid"
  var heroTextField = ""
  var selectedHero: Hero?
  var alliesTextField = ""
  var selectedAllies: [Hero] = []
  var enemiesTextField = ""
  var selectedEnemies: [Hero] = []

  func getTactics() async {
    isLoading = true
    defer {
      isLoading = false
    }
    guard let selectedHero else {
      error = "Please select hero"
      return
    }
    do {
      let tactics = try await OpenAIManager.shared.getTactics(
        for: selectedHero.displayName,
        lane: selectedLane,
        allies: selectedAllies.map { $0.displayName },
        enemies: selectedEnemies.map { $0.displayName }
      )
      currentTactics = tactics
      CoreDataManager.shared.saveTactics(
        itemBuild: tactics.itemBuild,
        strategy: tactics.strategy,
        heroName: selectedHero.displayName,
        heroIcon: selectedHero.icon
      )
    } catch {
      self.error = error.localizedDescription
    }
  }

  func filterHeroes(by name: String) {
    popupHeroes = allHeroes.filter { $0.displayName.lowercased().starts(with: name.lowercased()) }
  }

  func convertItemsIntoImages(items: [String]) -> [String] {
    return items.compactMap { itemString in
      if let itemObject = self.items.first(where: { $0.dname == itemString }) {
        return itemObject.img
      }
      return nil
    }
  }
}

// MARK: - Hero Picker

extension DotaTactixViewModel {
  func autocompleteHero() {
    if heroTextField.isEmpty {
      presentHeroPopup = false
      popupHeroes = []
    } else {
      filterHeroes(by: heroTextField)

      if popupHeroes.isEmpty {
        presentHeroPopup = false
        popupHeroes = []
      } else {
        presentHeroPopup = true
      }
    }
  }

  func selectHero(_ hero: Hero) {
    selectedHero = hero
    presentHeroPopup = false
    heroTextField = ""
    popupHeroes = []

    allHeroes.remove(hero)
  }

  func removeHero() {
    guard let selectedHero else {
      error = "No selected hero"
      return
    }
    allHeroes.insert(selectedHero)
    self.selectedHero = nil
  }
}

// MARK: - Allies Picker

extension DotaTactixViewModel {
  func autoCompleteAllies() {
    if alliesTextField.isEmpty {
      presentAlliesPopup = false
      popupHeroes = []
    } else {
      filterHeroes(by: alliesTextField)

      if popupHeroes.isEmpty {
        presentAlliesPopup = false
        popupHeroes = []
      } else {
        presentAlliesPopup = true
      }
    }
  }

  func selectAlly(hero: Hero) {
    selectedAllies.append(hero)
    presentHeroPopup = false
    alliesTextField = ""
    popupHeroes = []

    allHeroes.remove(hero)
  }

  func removeAlly(hero: Hero) {
    selectedAllies.removeAll { $0.displayName == hero.displayName }
    allHeroes.insert(hero)
  }
}

// MARK: - Enemies Picker

extension DotaTactixViewModel {
  func autoCompleteEnemies() {
    if enemiesTextField.isEmpty {
      presentEnemiesPopup = false
      popupHeroes = []
    } else {
      filterHeroes(by: enemiesTextField)

      if popupHeroes.isEmpty {
        presentEnemiesPopup = false
        popupHeroes = []
      } else {
        presentEnemiesPopup = true
      }
    }
  }

  func selectEnemy(hero: Hero) {
    selectedEnemies.append(hero)
    presentEnemiesPopup = false
    enemiesTextField = ""
    popupHeroes = []

    allHeroes.remove(hero)
  }

  func removeEnemy(hero: Hero) {
    selectedEnemies.removeAll { $0.displayName == hero.displayName }
    allHeroes.insert(hero)
  }
}
