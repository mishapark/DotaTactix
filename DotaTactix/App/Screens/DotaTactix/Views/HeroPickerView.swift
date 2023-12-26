//
//  HeroPickerView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct HeroPickerView: View {
  @Bindable var viewModel: DotaTactixViewModel
  var focusedField: FocusState<FocusedField?>.Binding

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Select hero")
          .boldFont(size: 20)
        Text("(Required)")
          .boldFont(color: .accent)
        Spacer()
      }
      if let selectedHero = viewModel.selectedHero {
        HeroCapsuleView(icon: selectedHero.icon, name: selectedHero.displayName) {
          viewModel.removeHero()
          focusedField.wrappedValue = .hero
        }
      } else {
        TextField("", text: $viewModel.heroTextField, prompt: Text("Select hero").foregroundColor(.grayLight))
          .regularFont()
          .cardBackground()
          .focused(focusedField, equals: .hero)
          .onChange(of: viewModel.heroTextField) {
            viewModel.autocompleteHero()
          }
          .popover(isPresented: $viewModel.presentHeroPopup) {
            PopoverView(heroes: viewModel.popupHeroes) { hero in
              viewModel.selectHero(hero)
            }
          }
      }
    }
  }
}

#Preview {
  DotaTactixView()
}
