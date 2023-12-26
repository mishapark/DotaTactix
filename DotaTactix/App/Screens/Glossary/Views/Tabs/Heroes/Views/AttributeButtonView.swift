//
//  AttributeButton.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct AttributeButtonView: View {
  var viewModel: GlossaryViewModel
  var attribute: String

  var body: some View {
    Image(attribute)
      .resizable()
      .renderingMode(viewModel.attributeFilter == attribute ? .original : .template)
      .foregroundStyle(.black.opacity(0.5))
      .frame(width: 30, height: 30)
      .padding(5)
      .background(viewModel.attributeFilter == attribute ? .white : .grayLight)
      .cornerRadius(5)
  }
}

#Preview {
  AttributeButtonView(viewModel: GlossaryViewModel(), attribute: "agi")
}
