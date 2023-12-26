//
//  TacticsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-22.
//

import NukeUI
import SwiftUI

struct TacticsView: View {
  let tactics: Tactics
  let viewModel: DotaTactixViewModel

  var body: some View {
    BackgroundContainerView {
      ScrollView {
        VStack {
          HStack {
            Spacer()
            CloseButtonView()
          }

          Spacer()

          VStack(spacing: 20) {
            Subtitle(subtitle: "Item Build")
            VStack(spacing: 5) {
              ItemsBuildView(viewModel: viewModel, title: "Starting Items", items: tactics.itemBuild.startingItems)
              ItemsBuildView(viewModel: viewModel, title: "Early Game", items: tactics.itemBuild.earlyGame)
              ItemsBuildView(viewModel: viewModel, title: "Core Items", items: tactics.itemBuild.coreItems)
              ItemsBuildView(viewModel: viewModel, title: "Luxury Items", items: tactics.itemBuild.luxuryItems)
              ItemsBuildView(
                viewModel: viewModel,
                title: "Situational Items",
                items: tactics.itemBuild.situationalItems
              )
            }
          }
          .card(padding: 20)

          VStack(spacing: 20) {
            Subtitle(subtitle: "Strategy")
            StrategyView(title: "Early Game", strategy: tactics.strategy.earlyGame)
            StrategyView(title: "Mid Game", strategy: tactics.strategy.midGame)
            StrategyView(title: "Late Game", strategy: tactics.strategy.lateGame)
          }
          .card(padding: 20)

          Spacer()
        }
        .padding(.horizontal)
      }
      .scrollIndicators(.hidden)
    }
  }
}

#Preview {
  TacticsView(tactics: MockData.tactics, viewModel: DotaTactixViewModel())
}
