//
//  GlossaryTabView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct GlossaryTabView: View {
  @Namespace var glossaryNamespace
  @Binding var currentTab: GlossaryTabs

  var body: some View {
    HStack(spacing: 20) {
      ForEach(GlossaryTabs.allCases, id: \.self) { tab in
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
              .matchedGeometryEffect(id: "glossary", in: glossaryNamespace, properties: .frame)
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

#Preview {
  GlossaryTabView(currentTab: .constant(GlossaryTabs.heroes))
}
