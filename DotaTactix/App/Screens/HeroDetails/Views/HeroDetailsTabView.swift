//
//  HeroDetailsTabView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroDetailsTabView: View {
  @Namespace var heroDetailsNamespace
  @Binding var currentTab: HeroDetailsTabs

  var body: some View {
    HStack(spacing: 20) {
      ForEach(HeroDetailsTabs.allCases, id: \.self) { tab in
        VStack {
          HStack {
            Spacer()
            Text(tab.rawValue)
              .regularFont()
            Spacer()
          }
          if self.currentTab == tab {
            Color
              .blue
              .frame(width: 100, height: 2)
              .matchedGeometryEffect(id: "heroDetails", in: heroDetailsNamespace, properties: .frame)
          } else {
            Color.clear.frame(height: 2)
          }
        }
        .contentShape(Rectangle())
        .animation(.spring(), value: currentTab)
        .onTapGesture {
          withAnimation {
            self.currentTab = tab
          }
        }
      }
    }
  }
}
