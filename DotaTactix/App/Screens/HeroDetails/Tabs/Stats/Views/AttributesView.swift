//
//  AttributesView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct AttributesView: View {
  let viewModel: HeroDetailsViewModel

  var body: some View {
    VStack(alignment: .leading) {
      Text("Attributes")
        .blackFont(size: 20)
      HStack {
        VStack(spacing: 0) {
          HeroGridImageView(imageURL: viewModel.hero.image)
            .frame(width: 150)
          HMPBarView(value: 100, gradient: viewModel.hpGradient, gain: viewModel.hero.hpRegen)
          HMPBarView(value: 50, gradient: viewModel.mpGradient, gain: viewModel.hero.mpRegen)
        }
        Spacer()
        VStack(spacing: 10) {
          AttributeGainView(
            image: .str,
            attrBase: viewModel.hero.strengthBase,
            attrGain: viewModel.hero.strengthGain
          )
          AttributeGainView(
            image: .agi,
            attrBase: viewModel.hero.agilityBase,
            attrGain: viewModel.hero.agilityGain
          )
          AttributeGainView(
            image: .int,
            attrBase: viewModel.hero.intelligenceBase,
            attrGain: viewModel.hero.intelligenceGain
          )
        }
        .padding(.trailing, 25)
      }
    }
    .card(padding: 20)
  }
}
