//
//  GlossaryViewModel.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import Combine
import SwiftUI

enum GlossaryTabs: String, CaseIterable { case heroes = "Heroes"; case items = "Items" }

@Observable
class GlossaryViewModel {
  var currentTab: GlossaryTabs = .heroes
  var isLoading = false
  var showAlert = false
  var error = "" {
    didSet {
      showAlert = !error.isEmpty
    }
  }

  var heroes: [Hero] = HeroManager.shared.heroes
  var items: [(String, [Item])] = []

  var attributeFilter: String?
  var complexityFilter: Int?
  var heroSearchText: String = ""

  var itemSearchText: String = ""

  private var sortedItemsCancellable: Set<AnyCancellable> = []

  @ObservationIgnored var heroColumns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
  @ObservationIgnored var itemColumns = [
    GridItem(.flexible(), spacing: 5),
    GridItem(.flexible(), spacing: 5),
    GridItem(.flexible(), spacing: 5),
    GridItem(.flexible(), spacing: 5),
    GridItem(.flexible(), spacing: 5)
  ]

  init() {
    ItemManager.shared.$sortedItems
      .sink { [weak self] sortedItems in
        self?.items = sortedItems
      }
      .store(in: &sortedItemsCancellable)
    HeroManager.shared.$heroes
      .sink { [weak self] heroes in
        self?.heroes = heroes
      }
      .store(in: &sortedItemsCancellable)
  }

  func refreshData() async {
    isLoading = true
    defer {
      isLoading = false
    }
    do {
      try await ItemManager.shared.refreshItems()
      try await HeroManager.shared.refreshHeroes()
    } catch {
      self.error = error.localizedDescription
    }
  }
}

// MARK: - Filter Items

extension GlossaryViewModel {
  var filteredItems: [(String, [Item])] {
    if !itemSearchText.isEmpty {
      return items.map { category, items -> (String, [Item]) in
        let filteredItems = items.filter {
          if let name = $0.dname {
            return name.contains(itemSearchText)
          }
          return false
        }
        return (category, filteredItems)
      }
    }
    return items
  }
}

// MARK: - Filter Heroes

extension GlossaryViewModel {
  func setAttributeFilter(attribute: AttributePrimary) {
    if attributeFilter == nil {
      attributeFilter = attribute.rawValue
    } else if attributeFilter != nil, attributeFilter != attribute.rawValue {
      attributeFilter = attribute.rawValue
    } else {
      attributeFilter = nil
    }
  }

  func setComplexityFilter(complexity: Int) {
    if complexityFilter == nil {
      complexityFilter = complexity
    } else if complexityFilter != nil, complexityFilter != complexity {
      complexityFilter = complexity
    } else {
      complexityFilter = nil
    }
  }

  var filteredHeroes: [Hero] {
    if attributeFilter != nil, complexityFilter != nil, !heroSearchText.isEmpty {
      return heroes
        .filter { $0.attributePrimary.rawValue == attributeFilter }
        .filter { $0.complexity == complexityFilter }
        .filter { $0.displayName.contains(heroSearchText) }
    }
    if attributeFilter != nil, complexityFilter != nil {
      return heroes
        .filter { $0.attributePrimary.rawValue == attributeFilter }
        .filter { $0.complexity == complexityFilter }
    }
    if attributeFilter != nil, !heroSearchText.isEmpty {
      return heroes
        .filter { $0.attributePrimary.rawValue == attributeFilter }
        .filter { $0.displayName.contains(heroSearchText) }
    }
    if complexityFilter != nil, !heroSearchText.isEmpty {
      return heroes
        .filter { $0.complexity == complexityFilter }
        .filter { $0.displayName.contains(heroSearchText) }
    }
    if !heroSearchText.isEmpty {
      return heroes
        .filter { $0.displayName.contains(heroSearchText) }
    }
    if attributeFilter != nil {
      return heroes
        .filter { $0.attributePrimary.rawValue == attributeFilter }
    }
    if complexityFilter != nil {
      return heroes
        .filter { $0.complexity == complexityFilter }
    }
    return heroes
  }
}
