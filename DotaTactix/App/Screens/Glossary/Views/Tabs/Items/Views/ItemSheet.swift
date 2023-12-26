//
//  ItemSheet.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import NukeUI
import SwiftUI

struct ItemSheet: View {
  var item: Item

  @State private var animateText = false

  var body: some View {
    BackgroundContainerView {
      ZStack(alignment: .topTrailing) {
        CloseButtonView()
          .padding(20)
        VStack {
          Spacer()
          VStack(spacing: 10) {
            HStack(alignment: .top) {
              LazyImage(url: URL(string: "https://api.opendota.com\(item.img)")) { state in
                if state.error != nil {
                  EmptyView()
                } else if let image = state.image {
                  image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                } else {
                  ProgressView()
                    .tint(.accent)
                }
              }
              .padding(.trailing, 10)

              VStack(alignment: .leading, spacing: 5) {
                if let name = item.dname {
                  Text(name)
                    .boldFont(size: 20)
                }
                HStack {
                  if let cost = item.cost, cost != 0 {
                    HStack(spacing: 3) {
                      Image(.gold)
                      Text("\(cost)")
                        .regularFont(size: 15, color: .yellow)
                    }
                  }
                  if case .integer(let charges) = item.charges {
                    Text("Stock: \(charges)")
                      .regularFont(size: 15)
                  }
                }
              }
              .opacity(animateText ? 1 : 0)
              Spacer()
            }
            if let hint = item.hint {
              VStack(alignment: .leading) {
                ForEach(hint, id: \.self) { hintItem in
                  Text(hintItem)
                    .regularFont()
                }
              }
              .padding(10)
              .frame(maxWidth: .infinity)
              .background(.grayDark.opacity(0.7))
              .opacity(animateText ? 1 : 0)
            }

            HStack {
              if case .integer(let cooldown) = item.cooldown {
                HStack(spacing: 0) {
                  Image(.cooldown)
                    .cornerRadius(3)
                    .padding(.trailing, 5)
                  Text("\(cooldown)")
                    .regularFont(size: 13)
                }
                Spacer()
              }

              if case .integer(let manacost) = item.manacost {
                Spacer()
                HStack(spacing: 0) {
                  Color.blue
                    .saturation(5)
                    .frame(width: 16, height: 16)
                    .cornerRadius(3)
                    .padding(.trailing, 5)
                  Text("\(manacost)")
                    .regularFont(size: 13)
                }
              }
            }
            .opacity(animateText ? 1 : 0)

            if !item.lore.isEmpty {
              Text(item.lore)
                .regularFont(size: 15)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.grayDark.opacity(0.3))
                .opacity(animateText ? 1 : 0)
            }
          }
          .padding(10)
          .background(.black.opacity(0.3))
          .cornerRadius(5)
          .onAppear {
            withAnimation(.linear.delay(0.3)) {
              animateText = true
            }
          }
          .padding(.horizontal)
          Spacer()
        }
      }
    }
  }
}
