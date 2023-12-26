//
//  GlossaryView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI

struct GlossaryView: View {
  @State private var viewModel = GlossaryViewModel()

  @Environment(\.dismiss)
  var dismiss

  var body: some View {
    NavigationStack {
      BackgroundContainerView {
        VStack {
          TabTitleWithButton(title: "Glossary", icon: "arrow.counterclockwise") {
            Task {
              await viewModel.refreshData()
            }
          }
          .padding(.horizontal)

          GlossaryTabView(currentTab: $viewModel.currentTab)

          ZStack {
            TabView(selection: $viewModel.currentTab) {
              HeroesView(viewModel: viewModel)
                .padding(.horizontal)
                .tag(GlossaryTabs.heroes)
              ItemsView(viewModel: viewModel)
                .tag(GlossaryTabs.items)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            if viewModel.isLoading {
              LoadingView(text: "Retrieving fresh data")
            }
          }
        }
      }
      .navigationDestination(for: Hero.self) { hero in
        HeroDetailsView(viewModel: HeroDetailsViewModel(hero: hero))
      }
    }
    .alert(viewModel.error, isPresented: $viewModel.showAlert) {
      Button("OK", role: .cancel) {}
    }
  }
}

#Preview {
  GlossaryView()
}
