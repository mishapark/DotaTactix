//
//  HeroesView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroesView: View {
  var viewModel: GlossaryViewModel

  var body: some View {
    VStack {
      HeroFilterView(viewModel: viewModel)
      HeroesGridView(viewModel: viewModel)
    }
  }
}

#Preview {
  HeroesView(viewModel: GlossaryViewModel())
}
