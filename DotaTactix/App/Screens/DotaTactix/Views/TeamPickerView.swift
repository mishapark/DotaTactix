//
//  TeamPickerView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct AlliesPickerView: View {
  @Bindable var viewModel: DotaTactixViewModel
  var focusedField: FocusState<FocusedField?>.Binding

  var hasReachedMax: Bool {
    viewModel.selectedAllies.count == 4
  }

  var body: some View {
    VStack(alignment: .leading) {
      Subtitle(subtitle: "Allies")
      TextField(
        "",
        text: $viewModel.alliesTextField,
        prompt: Text(hasReachedMax
          ? "Reached maximum number of heroes (4)"
          : "Select allies")
          .foregroundColor(hasReachedMax ? .white : .grayLight)
      )
      .disabled(hasReachedMax)
      .focused(focusedField, equals: .allies)
      .onChange(of: viewModel.alliesTextField) { viewModel.autoCompleteAllies() }
      .popover(isPresented: $viewModel.presentAlliesPopup) {
        PopoverView(heroes: viewModel.popupHeroes) { hero in
          viewModel.selectAlly(hero: hero)
          focusedField.wrappedValue = .allies
        }
      }
      .regularFont()
      .padding(10)
      .background(hasReachedMax
        ? .grayLight : .grayDark)
      .cornerRadius(5)

      if !viewModel.selectedAllies.isEmpty {
        FlowLayout(spacing: 5) {
          ForEach(viewModel.selectedAllies) { ally in
            HeroIconView(icon: ally.icon, name: ally.displayName) {
              viewModel.removeAlly(hero: ally)
            }
          }
        }
      } else {
        Text("Your ally team will appear here")
          .regularFont()
          .frame(maxWidth: .infinity)
          .padding(8)
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(.grayLight, lineWidth: 2)
          )
      }
    }
  }
}

struct EnemiesPickerView: View {
  @Bindable var viewModel: DotaTactixViewModel
  var focusedField: FocusState<FocusedField?>.Binding

  var hasReachedMax: Bool {
    viewModel.selectedEnemies.count == 5
  }

  var body: some View {
    VStack(alignment: .leading) {
      Subtitle(subtitle: "Enemies")
      TextField(
        "",
        text: $viewModel.enemiesTextField,
        prompt: Text(hasReachedMax
          ? "Reached maximum number of heroes (5)"
          : "Select enemies"
        )
        .foregroundColor(hasReachedMax ? .white : .grayLight)
      )
      .disabled(hasReachedMax)
      .focused(focusedField, equals: .enemies)
      .onChange(of: viewModel.enemiesTextField) { viewModel.autoCompleteEnemies() }
      .popover(isPresented: $viewModel.presentEnemiesPopup) {
        PopoverView(heroes: viewModel.popupHeroes) { hero in
          viewModel.selectEnemy(hero: hero)
          focusedField.wrappedValue = .enemies
        }
      }
      .regularFont()
      .padding(10)
      .background(hasReachedMax
        ? .grayLight : .grayDark)
      .cornerRadius(5)

      if !viewModel.selectedEnemies.isEmpty {
        FlowLayout(spacing: 5) {
          ForEach(viewModel.selectedEnemies) { enemy in
            HeroIconView(icon: enemy.icon, name: enemy.displayName) {
              viewModel.removeEnemy(hero: enemy)
            }
          }
        }
      } else {
        Text("Your enemy team will appear here")
          .regularFont()
          .frame(maxWidth: .infinity)
          .padding(8)
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(.grayLight, lineWidth: 2)
          )
      }
    }
  }
}

#Preview {
  DotaTactixView()
}
