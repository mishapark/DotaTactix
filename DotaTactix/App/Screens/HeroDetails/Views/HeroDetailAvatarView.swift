//
//  HeroDetailsAvatarView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import NukeUI
import SwiftUI

struct HeroDetailAvatarView: View {
  var imageURL: String

  var body: some View {
    LazyImage(url: URL(string: imageURL)) { state in
      if (state.error) != nil {
        EmptyView()
      } else if let image = state.image {
        image
          .resizable()
          .scaledToFit()
          .clipShape(Circle())
          .overlay(
            Circle().stroke(Color.white, lineWidth: 5)
          )
          .shadow()
      } else {
        ProgressView()
          .tint(.accent)
      }
    }
    .frame(width: 150, height: 150)
    .padding(.vertical, 10)
  }
}

#Preview {
  HeroDetailAvatarView(imageURL: MockData.hero.verticalImage)
}
