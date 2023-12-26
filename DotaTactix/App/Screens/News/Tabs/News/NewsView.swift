//
//  NewsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-19.
//

import SwiftUI

struct NewsView: View {
  var viewModel: NewsUpdatesViewModel

  var body: some View {
    ZStack {
      ScrollView {
        LazyVStack {
          ForEach(viewModel.news, id: \.gid) { news in
            NewsCardView(viewModel: viewModel, news: news)
          }
        }
        .tabViewPadding()
      }
      .scrollIndicators(.hidden)
      .refreshable {
        Task {
          await viewModel.fetchNews()
        }
      }

      if viewModel.isNewsLoading {
        LoadingView()
      }
    }
  }
}

#Preview {
  NewsView(viewModel: NewsUpdatesViewModel())
}
