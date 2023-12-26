//
//  HeroTalentsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-18.
//

import SwiftUI

struct HeroTalentsView: View {
  var viewModel: HeroDetailsViewModel
  let levelsToAddTalents: [Int] = [25, 20, 15, 10]

  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        ForEach(viewModel.hero.talents.indices, id: \.self) { index in
          if index % 2 == 0 {
            let leftTalent = viewModel.hero.talents.reversed()[index]
            let rightTalent =
              index + 1 < viewModel.hero.talents.count
                ? viewModel.hero.talents.reversed()[index + 1]
                : nil
            let level = levelsToAddTalents[index / 2]

            TalentRowView(leftTalent: leftTalent, rightTalent: rightTalent, level: level)
          }
        }
        Spacer()
      }
      .padding(.horizontal)
    }
  }
}
