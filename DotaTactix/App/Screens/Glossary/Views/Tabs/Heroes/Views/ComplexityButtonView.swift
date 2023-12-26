//
//  ComplexityButtonView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct ComplexityButtonView: View {
  var viewModel: GlossaryViewModel
  var complexityLevel: Int

  var body: some View {
    Rectangle()
      .padding(7)
      .rotationEffect(.degrees(45))
      .foregroundStyle(.black.opacity(0.5))
      .frame(width: 30, height: 30)
      .padding(5)
      .background(complexityLevel <= viewModel.complexityFilter ?? 0 ? .white : .grayLight)
      .cornerRadius(5)
  }
}

#Preview {
  ComplexityButtonView(viewModel: GlossaryViewModel(), complexityLevel: 3)
}
