//
//  NewsTab View.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-18.
//

import SwiftUI

struct NewsUpdatesTabView: View {
  @Namespace var newsNamespace
  @Binding var currentTab: NewsTabs

  var body: some View {
    HStack(spacing: 20) {
      ForEach(NewsTabs.allCases, id: \.self) { tab in
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
              .matchedGeometryEffect(id: "news", in: newsNamespace, properties: .frame)
          } else {
            Color.clear.frame(height: 2)
          }
        }
        .contentShape(Rectangle())
        .animation(.spring(), value: currentTab)
        .onTapGesture {
          withAnimation {
            currentTab = tab
          }
        }
      }
    }
  }
}
