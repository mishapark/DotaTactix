//
//  HeroRolesView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroRolesView: View {
  let hero: Hero

  var body: some View {
    HStack {
      ForEach(hero.roles.prefix(3), id: \.self) { role in
        Text("\(role)".uppercased())
          .regularFont(size: 13)
      }
      Spacer()
    }
    .lineLimit(1)
    .minimumScaleFactor(0.75)
  }
}

#Preview {
  HeroRolesView(hero: MockData.hero)
}
