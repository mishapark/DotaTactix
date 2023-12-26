//
//  SkillDescriptionView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct SkillDescriptionView: View {
  var title: String
  var data: String
  var dataColor: Color?

  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      Text(title)
        .regularFont(size: 13, color: .gray)
      Text(data)
        .regularFont(size: 13, color: dataColor ?? .white)
    }
  }
}
