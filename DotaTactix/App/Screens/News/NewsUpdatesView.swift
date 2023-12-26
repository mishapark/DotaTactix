//
//  NewsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI
import WebKit

struct NewsUpdatesView: View {
  @State private var viewModel = NewsUpdatesViewModel()

  var body: some View {
    NavigationStack {
      BackgroundContainerView {
        VStack {
          HStack {
            TabTitle(title: viewModel.tabTitle)
            if viewModel.currentTab == .updates, let url = URL(string: viewModel.patchesURL) {
              Link(destination: url) {
                Image(systemName: "globe")
                  .boldFont(size: 20, color: .accent)
              }
            }
          }
          .padding(.horizontal)

          NewsUpdatesTabView(currentTab: $viewModel.currentTab)
            .onChange(of: viewModel.currentTab) { _, newValue in
              viewModel.tabTitle = newValue.rawValue
            }

          TabView(selection: $viewModel.currentTab) {
            NewsView(viewModel: viewModel)
              .padding(.horizontal)
              .tag(NewsTabs.news)
            UpdatesWebView(viewModel: viewModel)
              .tag(NewsTabs.updates)
          }
          .tabViewStyle(.page(indexDisplayMode: .never))
          .edgesIgnoringSafeArea(.all)
        }
      }
    }
    .task {
      await viewModel.fetchNews()
    }
    .alert(viewModel.error, isPresented: $viewModel.showAlert) {
      Button("OK", role: .cancel) {}
    }
  }
}

#Preview {
  NewsUpdatesView()
}
