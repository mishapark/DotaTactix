//
//  SwiftUIView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroStatsView: View {
  let viewModel: HeroDetailsViewModel

  var body: some View {
    ScrollView {
      VStack {
        HeroAboutView(bio: viewModel.hero.bio, shortBio: viewModel.hero.shortBio)
        AttributesView(viewModel: viewModel)
        StatsView(viewModel: viewModel)
      }
      .padding(.horizontal)
      .tabViewPadding()
    }
    .scrollIndicators(.hidden)
  }
}

#Preview {
  HeroStatsView(viewModel: HeroDetailsViewModel(hero: MockData.hero))
}
