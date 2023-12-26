//
//  SearchTextField.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct SearchTextField: View {
  var text: Binding<String>

  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
      TextField("", text: text)
    }
    .foregroundStyle(.grayLight)
    .padding(10)
    .background(.grayDark)
    .cornerRadius(5)
    .regularFont()
  }
}

#Preview {
  SearchTextField(text: .constant(""))
}
