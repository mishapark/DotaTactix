//
//  SwiftUIView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct TabTitle: View {
  var title: String
  var body: some View {
    HStack {
      Text(title)
        .boldFont(size: 34)
        .padding(.vertical, 10)
      Spacer()
    }
  }
}

struct TabTitleWithButton: View {
  var title: String
  var icon: String
  var action: () -> Void

  var body: some View {
    HStack {
      Text(title)
        .boldFont(size: 34)
        .padding(.vertical, 10)
      Spacer()
      Button {
        action()
      } label: {
        Image(systemName: icon)
          .resizable()
          .frame(width: 20, height: 20)
      }
    }
  }
}

struct Subtitle: View {
  var subtitle: String
  var body: some View {
    HStack {
      Text(subtitle)
        .boldFont(size: 20)
      Spacer()
    }
  }
}

#Preview {
  TabTitle(title: "Glossary")
}
