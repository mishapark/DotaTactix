//
//  TalentRowView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct TalentRowView: View {
  let leftTalent: Talent?
  let rightTalent: Talent?
  let level: Int

  var body: some View {
    HStack {
      Text("\(level)")
        .blackFont(size: 25)
        .padding(15)
        .background(.accent)
        .clipShape(Circle())
        .overlay(
          Circle().stroke(Color.white, lineWidth: 2)
        )
        .padding(.trailing, 5)

      VStack {
        Text(leftTalent?.ability.dname ?? "")
          .regularFont(size: 15)
          .frame(maxWidth: .infinity)
          .card(padding: 5)
          .lineLimit(1)
          .minimumScaleFactor(0.75)

        Text(rightTalent?.ability.dname ?? "")
          .regularFont(size: 15)
          .frame(maxWidth: .infinity)
          .card(padding: 5)
          .lineLimit(1)
          .minimumScaleFactor(0.75)
      }
    }
  }
}
