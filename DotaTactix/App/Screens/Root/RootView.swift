//
//  AppTabView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI

@MainActor
struct RootView: View {
  @State private var viewModel = RootViewModel()

  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $viewModel.selectedTab) {
        DotaTactixView()
          .tag(0)
          .toolbar(.hidden, for: .tabBar)

        NewsUpdatesView()
          .tag(1)
          .toolbar(.hidden, for: .tabBar)

        GlossaryView()
          .tag(2)
          .toolbar(.hidden, for: .tabBar)
          .ignoresSafeArea(.keyboard)
      }

      CustomTabView(viewModel: viewModel)
    }
    .onTapGesture {
      endTextEditing()
    }
    .ignoresSafeArea(.keyboard)
    .task {
      await viewModel.fetchHeroes()
      await viewModel.fetchItems()
    }
    .alert(viewModel.error, isPresented: $viewModel.showAlert) {
      Button("OK", role: .cancel) {}
    }
  }
}

#Preview {
  RootView()
}
