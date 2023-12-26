//
//  HeroAttributeView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroAttributeView: View {
  let hero: Hero

  var body: some View {
    HStack(spacing: 20) {
      Image(hero.attributePrimary.rawValue)
        .resizable()
        .scaledToFit()
        .frame(width: 25)
      HStack(spacing: 7) {
        Image(hero.attackType == .melee ? .sword1 : .bow)
          .resizable()
          .renderingMode(.template)
          .scaledToFit()
          .frame(width: 20, height: 20)
          .regularFont()
        Text(hero.attackType.rawValue.uppercased())
          .regularFont(size: 13)
          .lineLimit(1)
          .minimumScaleFactor(0.75)
      }
      HStack {
        ForEach(1 ..< 4) { index in
          Rectangle()
            .frame(width: 10, height: 10)
            .foregroundStyle(index <= hero.complexity ? .white : .grayLight)
            .rotationEffect(.degrees(45))
        }
      }
      Spacer()
    }
  }
}

#Preview {
  HeroAttributeView(hero: MockData.hero)
}
