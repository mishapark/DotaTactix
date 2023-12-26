//
//  HeroIconView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import NukeUI
import SwiftUI

struct HeroIconView: View {
  let icon: String
  let name: String
  let removeCapsule: () -> Void

  var body: some View {
    HStack {
      LazyImage(url: URL(string: icon)) { state in
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
      .frame(width: 22, height: 22)
      Button("", systemImage: "xmark.circle") {
        removeCapsule()
      }
    }
    .padding(.vertical, 7)
    .padding(.leading, 7)
    .background(.grayDark)
    .cornerRadius(5)
  }
}
