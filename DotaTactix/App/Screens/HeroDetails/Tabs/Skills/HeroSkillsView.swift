//
//  HeroSkillsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import NukeUI
import SwiftUI

struct HeroSkillsView: View {
  let viewModel: HeroDetailsViewModel

  var body: some View {
    ScrollView {
      VStack {
        ForEach(viewModel.hero.abilities, id: \.slot) { skill in
          SkillCardView(skill: skill)
        }
      }
      .padding(.horizontal)
      .tabViewPadding()
    }
    .scrollIndicators(.hidden)
  }
}

#Preview {
  HeroDetailsView(viewModel: HeroDetailsViewModel(hero: MockData.hero))
}
