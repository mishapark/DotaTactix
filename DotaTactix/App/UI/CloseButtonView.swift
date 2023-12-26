//
//  CloseButton.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct CloseButtonView: View {
  @Environment(\.dismiss)
  var dismiss

  var body: some View {
    Button {
      dismiss()
    } label: {
      Image(systemName: "xmark.circle")
        .resizable()
        .frame(width: 25, height: 25)
    }
  }
}

#Preview {
  CloseButtonView()
}
