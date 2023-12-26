//
//  HeroDetailsViewModel.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

enum HeroDetailsTabs: String, CaseIterable {
  case stats = "Stats"
  case skills = "Skills"
  case talents = "Talents"
}

@Observable
class HeroDetailsViewModel {
  let hero: Hero

  init(hero: Hero) {
    self.hero = hero
  }

  var currentTab: HeroDetailsTabs = .stats

  var hpGradient = LinearGradient(
    colors: [
      Color(red: 0.0, green: 0.3, blue: 0.0),
      Color(red: 0.3, green: 1, blue: 0.5)
    ],
    startPoint: .leading,
    endPoint: .trailing
  )

  var mpGradient = LinearGradient(
    colors: [
      Color(red: 0, green: 0, blue: 0.5),
      Color(red: 0.3, green: 0.8, blue: 1)
    ],
    startPoint: .leading,
    endPoint: .trailing
  )
}
