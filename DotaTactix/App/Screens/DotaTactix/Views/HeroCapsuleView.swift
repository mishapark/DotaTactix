//
//  HeroCapsuleView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-23.
//

import NukeUI
import SwiftUI

struct HeroCapsuleView: View {
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
      Text(name)
        .regularFont()
        .padding(.trailing, 5)
      Button("", systemImage: "xmark.circle") {
        removeCapsule()
      }
    }
    .cardBackground()
  }
}
