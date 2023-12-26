//
//  HomeView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import NukeUI
import SwiftUI

enum FocusedField: Int, CaseIterable { case hero, allies, enemies }

struct DotaTactixView: View {
  @State private var viewModel = DotaTactixViewModel()
  @FocusState private var focusedField: FocusedField?

  var body: some View {
    NavigationStack {
      BackgroundContainerView {
        ZStack {
          VStack {
            ZStack {
              HStack {
                Spacer()
                NavigationLink {
                  TacticsListView(viewModel: viewModel)
                    .navigationBarBackButtonHidden()
                } label: {
                  Image(systemName: "clock")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.accent)
                }
              }
              HStack {
                Spacer()
                Image(.dtlogo)
                  .resizable()
                  .scaledToFit()
                  .frame(height: 35)
                Spacer()
              }

            }
            .padding(.horizontal)
            ScrollView {
              VStack {
                HStack {
                  Image(systemName: "info.circle")
                  Text("OpenAI can make mistakes. Please try again if Tactix does not get generated.")
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                  Spacer()
                }
                .padding(10)
                .background(.white)
                .cornerRadius(5)
                .boldFont(size: 15, color: .accent)

                VStack(alignment: .leading, spacing: 15) {
                  HeroPickerView(viewModel: viewModel, focusedField: $focusedField)
                  LanePickerView(viewModel: viewModel)
                  AlliesPickerView(viewModel: viewModel, focusedField: $focusedField)
                  EnemiesPickerView(viewModel: viewModel, focusedField: $focusedField)
                  TactixButtonView(viewModel: viewModel)
                    .padding(.top, 10)
                }
                .card(padding: 10)
              }
              .tabViewPadding()
              .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
          }
          if viewModel.isLoading {
            LoadingView(text: "Generating Tactix")
          }
        }
      }
      .fullScreenCover(item: $viewModel.currentTactics) { tactics in
        TacticsView(tactics: tactics, viewModel: viewModel)
      }
      .alert(viewModel.error, isPresented: $viewModel.showAlert) {
        Button("OK", role: .cancel) {}
      }
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          HStack {
            Button(action: focusPreviousField) {
              Image(systemName: "chevron.up")
            }
            .disabled(!canFocusPreviousField())
            Button(action: focusNextField) {
              Image(systemName: "chevron.down")
            }
            .disabled(!canFocusNextField())
            Spacer()
          }
        }
      }
    }
  }
}

#Preview {
  DotaTactixView()
}

extension DotaTactixView {
  private func focusPreviousField() {
    focusedField = focusedField.map {
      FocusedField(rawValue: $0.rawValue - 1) ?? .enemies
    }
  }

  private func focusNextField() {
    focusedField = focusedField.map {
      FocusedField(rawValue: $0.rawValue + 1) ?? .hero
    }
  }

  private func canFocusPreviousField() -> Bool {
    guard let currentFocusedField = focusedField else {
      return false
    }
    return currentFocusedField.rawValue > 0
  }

  private func canFocusNextField() -> Bool {
    guard let currentFocusedField = focusedField else {
      return false
    }
    return currentFocusedField.rawValue < FocusedField.allCases.count - 1
  }
}

struct TacticsListView: View {
  let viewModel: DotaTactixViewModel
  @State var archivedTactics: [TacticsArchivedModel] = []
  @State var currentTactics: TacticsArchivedModel?

  var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, h:mm a"

    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    dateFormatter.doesRelativeDateFormatting = true

    return dateFormatter
  }

  var body: some View {
    BackgroundContainerView {
      ScrollView {
        VStack {
          ForEach(archivedTactics.reversed()) { tactics in
            let formattedDate = dateFormatter.string(from: tactics.date)

            Button {
              currentTactics = tactics
            } label: {
              HStack {
                LazyImage(url: URL(string: tactics.heroIcon))
                Text(tactics.heroName)
                  .regularFont()
                Spacer()
                Text(formattedDate)
                  .regularFont()
              }
              .card(padding: 10)
              .padding(.horizontal)
            }
          }
        }
        .padding(.top, 20)
        .tabViewPadding()
      }
    }
    .navigationBarWithTitleAndDismiss(title: "Tactix History")
    .onAppear {
      archivedTactics = CoreDataManager.shared.getTactics()
    }
    .sheet(item: $currentTactics) { tactics in
      BackgroundContainerView {
        ScrollView {
          VStack {
            HStack {
              Spacer()
              CloseButtonView()
                .padding(.top, 10)
            }

            Spacer()

            VStack(spacing: 20) {
              Subtitle(subtitle: "Item Build")
              VStack(spacing: 5) {
                ItemsBuildView(viewModel: viewModel, title: "Starting Items", items: tactics.itemBuild.startingItems)
                ItemsBuildView(viewModel: viewModel, title: "Early Game", items: tactics.itemBuild.earlyGame)
                ItemsBuildView(viewModel: viewModel, title: "Core Items", items: tactics.itemBuild.coreItems)
                ItemsBuildView(viewModel: viewModel, title: "Luxury Items", items: tactics.itemBuild.luxuryItems)
                ItemsBuildView(
                  viewModel: viewModel,
                  title: "Situational Items",
                  items: tactics.itemBuild.situationalItems
                )
              }
            }
            .card(padding: 20)

            VStack(spacing: 20) {
              Subtitle(subtitle: "Strategy")
              StrategyView(title: "Early Game", strategy: tactics.strategy.earlyGame)
              StrategyView(title: "Mid Game", strategy: tactics.strategy.midGame)
              StrategyView(title: "Late Game", strategy: tactics.strategy.lateGame)
            }
            .card(padding: 20)

            Spacer()
          }
          .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
      }
    }
  }
}
