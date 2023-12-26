//
//  BackgroundView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct BackgroundView: View {
  var body: some View {
    LinearGradient(
      colors: [.grayDark.opacity(0.9), .grayLight],
      startPoint: .leading,
      endPoint: .trailing
    )
    .ignoresSafeArea()
  }
}

#Preview {
  BackgroundView()
}
