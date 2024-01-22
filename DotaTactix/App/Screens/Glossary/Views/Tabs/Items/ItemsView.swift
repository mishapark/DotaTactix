//
//  ItemsView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-19.
//

import NukeUI
import SwiftUI

struct ItemsView: View {
  @Bindable var viewModel: GlossaryViewModel
  @State private var currentItem: Item?

  var body: some View {
    ZStack {
      VStack {
        SearchTextField(text: $viewModel.itemSearchText)
          .padding(.horizontal)
        ScrollView {
          VStack {
            ForEach(viewModel.filteredItems, id: \.0) { quality, items in
              if !items.isEmpty {
                VStack {
                  Text(quality)
                    .boldFont(size: 20)
                  LazyVGrid(columns: viewModel.itemColumns, spacing: 5) {
                    ForEach(items) { item in
                      Button {
                        withAnimation {
                          currentItem = item
                        }
                      } label: {
                        LazyImage(url: URL(string: "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/\(item.name ?? "").png")) { state in
                          if state.error != nil {
                            EmptyView()
                          } else if let image = state.image {
                            image
                              .resizable()
                              .scaledToFit()
                          } else {
                            ProgressView()
                              .tint(.accent)
                          }
                        }
                      }
                    }
                  }
                }
                .card(padding: 10)
              }
            }
          }
          .padding(.horizontal)
          .tabViewPadding()
        }
        .scrollIndicators(.hidden)
      }
      .sheet(item: $currentItem) { item in
        ItemSheet(item: item)
      }
    }
  }
}

#Preview {
  GlossaryView()
}
