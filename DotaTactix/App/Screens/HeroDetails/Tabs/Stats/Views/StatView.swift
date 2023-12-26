//
//  StatView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct StatView: View {
  let image: ImageResource
  let text: String

  var body: some View {
    HStack {
      Image(image)
        .resizable()
        .frame(width: 20, height: 20)
      Text(text)
        .regularFont()
    }
  }
}
