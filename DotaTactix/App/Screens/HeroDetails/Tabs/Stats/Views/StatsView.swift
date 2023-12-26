//
//  StatsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct StatsView: View {
  let viewModel: HeroDetailsViewModel

  var body: some View {
    VStack(alignment: .leading) {
      Text("Stats")
        .blackFont(size: 20)
        .padding(.bottom, 5)
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Text("ATTACK")
            .boldFont(size: 15)
          StatView(image: .iconDamage, text: "\(viewModel.hero.startingDamageMin)-\(viewModel.hero.startingDamageMax)")
          StatView(image: .iconAttackTime, text: String(format: "%.1f", viewModel.hero.attackRate))
          StatView(image: .iconAttackRange, text: "\(viewModel.hero.attackRange)")
        }
        Spacer()
        VStack(alignment: .leading) {
          Text("DEFENSE")
            .boldFont(size: 15)
          StatView(image: .iconArmor, text: String(format: "%.1f", viewModel.hero.startingArmor))
          StatView(image: .iconMagicResist, text: "\(viewModel.hero.startingMagicArmor)%")
        }
        Spacer()
        VStack(alignment: .leading) {
          Text("MOBILITY")
            .boldFont(size: 15)
          StatView(image: .iconMovementSpeed, text: "\(viewModel.hero.moveSpeed)")
          StatView(image: .iconTurnRate, text: String(format: "%.1f", viewModel.hero.moveTurnRate))
          StatView(
            image: .iconVision,
            text: "\(viewModel.hero.visionDaytimeRange) / \(viewModel.hero.visionNighttimeRange)"
          )
        }
      }
    }
    .card(padding: 20)
  }
}
