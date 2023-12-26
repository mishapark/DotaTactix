//
//  StrategyView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct StrategyView: View {
  let title: String
  let strategy: String
  var strategyArray: [String] {
    strategy.components(separatedBy: ". ")
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      HStack {
        Text(title)
          .boldFont(size: 18)
        Spacer()
      }
      ForEach(strategyArray, id: \.self) { strategySentence in
        HStack(alignment: .top) {
          Image(systemName: "dot.circle.fill")
            .resizable()
            .foregroundStyle(.accent)
            .frame(width: 10, height: 10)
            .padding(.top, 6)
          Text(strategySentence)
            .regularFont()
        }
      }
    }
  }
}
