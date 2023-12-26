//
//  AppTabViewModel.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import Foundation

@Observable
class RootViewModel {
  var selectedTab = 0
  var showAlert = false
  var error = "" {
    didSet {
      showAlert = !error.isEmpty
    }
  }

  func fetchHeroes() async {
    do {
      try await HeroManager.shared.fetchHeroes()
    } catch {
      self.error = error.localizedDescription
    }
  }

  func fetchItems() async {
    do {
      try await ItemManager.shared.fetchItems()
    } catch {
      self.error = error.localizedDescription
    }
  }
}
