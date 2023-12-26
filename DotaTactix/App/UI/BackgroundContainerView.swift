//
//  ContainerView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI

struct BackgroundContainerView<Content: View>: View {
  var content: () -> Content

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }

  var body: some View {
    ZStack {
      BackgroundView()

      content()
    }
  }
}
