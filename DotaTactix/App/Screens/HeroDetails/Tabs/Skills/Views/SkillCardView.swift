//
//  SkillCardView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct SkillCardView: View {
  let skill: Ability

  var body: some View {
    VStack {
      SkillOverviewView(skill: skill)
        .padding(.bottom, 10)
      SkillStatsView(skill: skill)
    }
    .card(padding: 10)
  }
}
