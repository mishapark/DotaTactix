//
//  AttributeGainView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct AttributeGainView: View {
  var image: ImageResource
  var attrBase: Int
  var attrGain: Double

  var body: some View {
    HStack(spacing: 20) {
      Image(image)
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30)
      Text("\(attrBase)")
        .blackFont(size: 25)
      Text(String(format: "+%.1f", attrGain))
        .regularFont(size: 15)
    }
  }
}

#Preview {
  AttributeGainView(image: .agi, attrBase: 12, attrGain: 13)
}
