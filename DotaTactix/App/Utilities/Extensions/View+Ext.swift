//
//  View+Ext.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI

extension View {
  // MARK: - Text

  func regularFont(size: CGFloat = 17, color: Color = .white) -> some View {
    self.font(Font.custom("Lato-Regular", size: size)).foregroundStyle(color)
  }

  func thinFont(size: CGFloat = 17, color: Color = .white) -> some View {
    self.font(Font.custom("Lato-Thin", size: size)).foregroundStyle(color)
  }

  func lightFont(size: CGFloat = 17, color: Color = .white) -> some View {
    self.font(Font.custom("Lato-Light", size: size)).foregroundStyle(color)
  }

  func boldFont(size: CGFloat = 17, color: Color = .white) -> some View {
    self.font(Font.custom("Lato-Bold", size: size)).foregroundStyle(color)
  }

  func blackFont(size: CGFloat = 17, color: Color = .white) -> some View {
    self.font(Font.custom("Lato-Black", size: size)).foregroundStyle(color)
  }

  // MARK: - Modifiers

  func tabViewPadding() -> some View {
    self.padding(.bottom, 80)
  }

  func cornerRadius(_ size: CGFloat = 10) -> some View {
    self.clipShape(RoundedRectangle(cornerRadius: size))
  }

  func shadow() -> some View {
    self
      .shadow(color: .black.opacity(0.5), radius: 10)
  }

  // MARK: - Card

  func card(padding: CGFloat) -> some View {
    self
      .padding(padding)
      .background(.grayDark.opacity(0.5))
      .cornerRadius(5)
  }

  func cardBackground(padding: CGFloat = 10) -> some View {
    self
      .padding(padding)
      .background(.grayDark)
      .cornerRadius(5)
  }

  // MARK: - Navigation

  func navigationBarWithTitleAndDismiss(title: String) -> some View {
    self
      .toolbar {
        CustomToolBarContent(title: title)
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
      .navigationBarBackButtonHidden(true)
  }

  // MARK: - Keyboard

  func endTextEditing() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil
    )
  }
}

struct CustomToolBarContent: ToolbarContent {
  let title: String
  @Environment(\.dismiss)
  var dismiss

  var body: some ToolbarContent {
    ToolbarItem(placement: .principal) {
      Text(self.title)
        .boldFont(size: 22)
    }
    ToolbarItem(placement: .topBarLeading) {
      Button {
        self.dismiss()
      } label: {
        Image(systemName: "chevron.left")
          .foregroundStyle(.white)
      }
    }
  }
}
