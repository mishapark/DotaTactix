//
//  TactixButtonView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-23.
//

import SwiftUI

struct TactixButtonView: View {
  let viewModel: DotaTactixViewModel

  var body: some View {
    Button {
      Task {
        await viewModel.getTactics()
      }
    } label: {
      Text("Get Tactix")
        .blackFont(size: 23)
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .background(.accent)
        .cornerRadius(5)
    }
    .sensoryFeedback(.success, trigger: viewModel.currentTactics)
  }
}
