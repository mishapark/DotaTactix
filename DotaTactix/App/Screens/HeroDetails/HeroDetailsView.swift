//
//  HeroDetailsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroDetailsView: View {
  @State var viewModel: HeroDetailsViewModel

  var body: some View {
    BackgroundContainerView {
      VStack(spacing: 10) {
        HStack(spacing: 30) {
          HeroDetailAvatarView(imageURL: viewModel.hero.verticalImage)
          VStack(alignment: .leading, spacing: 15) {
            HeroNameView(name: viewModel.hero.displayName)
            HeroAttributeView(hero: viewModel.hero)
            HeroRolesView(hero: viewModel.hero)
          }
        }
        .padding(.horizontal)
        HeroDetailsTabView(currentTab: $viewModel.currentTab)

        TabView(selection: $viewModel.currentTab) {
          HeroStatsView(viewModel: viewModel)
            .tag(HeroDetailsTabs.stats)
          HeroSkillsView(viewModel: viewModel)
            .tag(HeroDetailsTabs.skills)
          HeroTalentsView(viewModel: viewModel)
            .tag(HeroDetailsTabs.talents)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
      }
    }
    .navigationBarWithTitleAndDismiss(title: viewModel.hero.displayName)
  }
}

#Preview {
  HeroDetailsView(viewModel: HeroDetailsViewModel(hero: MockData.hero))
}
