//
//  HeroNameView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroNameView: View {
  let name: String

  var body: some View {
    HStack {
      Text(name)
        .boldFont(size: 25)
        .lineLimit(1)
        .minimumScaleFactor(0.75)
      Spacer()
    }
  }
}

#Preview {
  HeroNameView(name: MockData.hero.name)
}
