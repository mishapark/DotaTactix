//
//  PopoverView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import NukeUI
import SwiftUI

struct PopoverView: View {
  let heroes: [Hero]
  let onTapHero: (_ hero: Hero) -> Void
  @Environment(\.colorScheme)
  var colorScheme

  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      ForEach(heroes) { hero in
        Button {
          onTapHero(hero)
        } label: {
          HStack {
            LazyImage(url: URL(string: hero.icon)) { state in
              if (state.error) != nil {
                EmptyView()
              } else if let image = state.image {
                image
                  .resizable()
                  .scaledToFit()
              } else {
                ProgressView()
                  .tint(.accent)
              }
            }
            .frame(width: 20, height: 20)
            Text(hero.displayName)
              .regularFont(color: colorScheme == .dark ? .white : .grayLight)
          }
        }
      }
    }
    .padding(10)
    .presentationCompactAdaptation(.popover)
  }
}
