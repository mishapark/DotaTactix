//
//  HeroButton.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import NukeUI
import SwiftUI

struct HeroGridImageView: View {
  var imageURL: String

  var body: some View {
    LazyImage(url: URL(string: imageURL)) { state in
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
  }
}
