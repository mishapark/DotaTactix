//
//  asd.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI

struct CustomTabItemView: View {
  var imageName: String
  var title: String
  var isActive: Bool

  var body: some View {
    HStack(spacing: 10) {
      Spacer()
      Image(imageName)
        .resizable()
        .renderingMode(.template)
        .foregroundColor(isActive ? .white : .black)
        .frame(width: 20, height: 20)
      Spacer()
    }
    .frame(height: 50)
    .frame(minWidth: isActive ? 150 : 0, maxWidth: .infinity)
    .background(isActive ? .accent : .clear)
    .clipShape(RoundedRectangle(cornerRadius: 5))
  }
}

#Preview {
  CustomTabItemView(imageName: "dota", title: "Dota", isActive: true)
}
