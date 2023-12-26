//
//  CustomTabView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI

struct CustomTabView: View {
  var viewModel: RootViewModel

  var body: some View {
    HStack {
      Spacer()
      ForEach(TabItems.allCases, id: \.self) { item in
        Button {
          withAnimation {
            viewModel.selectedTab = item.rawValue
          }
        } label: {
          CustomTabItemView(
            imageName: item.iconName,
            title: item.title,
            isActive: viewModel.selectedTab == item.rawValue
          )
        }
      }
      Spacer()
    }
    .frame(height: 60)
    .background(.ultraThinMaterial)
    .shadow()
    .clipShape(RoundedRectangle(cornerRadius: 5))
    .padding(.horizontal)
  }
}

#Preview {
  CustomTabView(viewModel: RootViewModel())
}
