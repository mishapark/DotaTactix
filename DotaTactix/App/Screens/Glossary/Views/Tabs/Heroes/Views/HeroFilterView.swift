//
//  HeroFilterView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroFilterView: View {
  @Bindable var viewModel: GlossaryViewModel

  var body: some View {
    VStack {
      SearchTextField(text: $viewModel.heroSearchText)

      HStack(spacing: 5) {
        ForEach(AttributePrimary.allCases, id: \.self) { attribute in
          AttributeButtonView(viewModel: viewModel, attribute: attribute.rawValue)
            .onTapGesture {
              withAnimation {
                viewModel.setAttributeFilter(attribute: attribute)
              }
            }
        }
        Spacer()
        ForEach(1 ..< 4) { index in
          Button {} label: {
            ComplexityButtonView(viewModel: viewModel, complexityLevel: index)
              .onTapGesture {
                withAnimation {
                  viewModel.setComplexityFilter(complexity: index)
                }
              }
          }
        }
      }
    }
    .card(padding: 10)
  }
}

#Preview {
  HeroFilterView(viewModel: GlossaryViewModel())
}
