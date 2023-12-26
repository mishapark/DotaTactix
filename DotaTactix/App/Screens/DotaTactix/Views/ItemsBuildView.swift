//
//  ItemsBuildView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import NukeUI
import SwiftUI

struct ItemsBuildView: View {
  let viewModel: DotaTactixViewModel
  let title: String
  let items: [String]

  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      HStack {
        Text(title)
          .boldFont(size: 18)
        Spacer()
      }
      VStack {
        HStack(spacing: 3) {
          ForEach(viewModel.convertItemsIntoImages(items: items), id: \.self) { itemImg in
            LazyImage(url: URL(string: "https://api.opendota.com\(itemImg)")) { state in
              if (state.error) != nil {
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
            .frame(height: 40)
            .padding(.trailing, 5)
            .padding(.bottom, 5)
          }
        }
      }
    }
  }
}
