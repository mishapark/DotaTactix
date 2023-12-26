//
//  HMPBarView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HMPBarView: View {
  var value: Int
  var gradient: LinearGradient
  var gain: Double

  var body: some View {
    ZStack(alignment: .trailing) {
      Rectangle()
        .frame(width: 150, height: 20)
        .foregroundStyle(gradient)

      Text(String(format: "+%.1f", gain))
        .boldFont(size: 13, color: .grayDark)
        .shadow()
        .padding(.trailing, 10)
      HStack {
        Spacer()
        Text("\(value)")
          .boldFont(size: 16, color: .white)
          .shadow()
        Spacer()
      }
      .frame(width: 150, height: 20)
    }
  }
}

#Preview {
  HMPBarView(
    value: 100,
    gradient: HeroDetailsViewModel(hero: MockData.hero).hpGradient,
    gain: HeroDetailsViewModel(hero: MockData.hero).hero.hpRegen
  )
}
