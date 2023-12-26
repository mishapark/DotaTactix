//
//  HeroesGridView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroesGridView: View {
  var viewModel: GlossaryViewModel

  var body: some View {
    ScrollView {
      LazyVGrid(columns: viewModel.heroColumns) {
        ForEach(viewModel.filteredHeroes) { hero in
          NavigationLink(value: hero) {
            HeroGridImageView(imageURL: hero.image)
          }
        }
      }
      .tabViewPadding()
    }
    .shadow()
    .scrollIndicators(.hidden)
  }
}

#Preview {
  HeroesView(viewModel: GlossaryViewModel())
}
