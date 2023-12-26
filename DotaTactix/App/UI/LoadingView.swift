//
//  LoadingView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct LoadingView: View {
  var text: String = "Loading"

  var body: some View {
    VStack(spacing: 20) {
      Text(text)
        .regularFont(size: 19, color: .white)
      ProgressView()
        .tint(.accent)
    }
    .padding(30)
    .background(.thickMaterial)
    .cornerRadius(5)
  }
}

#Preview {
  LoadingView()
}
