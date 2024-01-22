//
//  SkillOverviewView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import NukeUI
import SwiftUI

struct SkillOverviewView: View {
  let skill: Ability

  @State var isExpanded = false
  @State private var canBeExpanded = false

  var body: some View {
    HStack(alignment: .top, spacing: 15) {
      LazyImage(url: URL(string: "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/\(skill.ability.name ?? "").png")) { state in
        if (state.error) != nil {
          EmptyView()
        } else if let image = state.image {
          image
            .resizable()
            .scaledToFit()
            .shadow()
        } else {
          ProgressView()
            .tint(.accent)
        }
      }
      .frame(width: 100, height: 100)

      VStack(alignment: .leading) {
        HStack {
          Text(skill.ability.dname ?? "")
            .regularFont(size: 20)
            .lineLimit(1)
            .minimumScaleFactor(0.75)
          Spacer()
          if canBeExpanded {
            Button {
              withAnimation {
                isExpanded.toggle()
              }
            } label: {
              Text(isExpanded ? "Read less" : "Read more")
                .boldFont(size: 13, color: .accent)
                .underline()
            }
          }
        }
        .padding(.bottom, 5)

        Text(skill.ability.desc ?? "")
          .regularFont()
          .lineLimit(isExpanded ? nil : 3)
          .background {
            ViewThatFits(in: .vertical) {
              Text(skill.ability.desc ?? "")
                .regularFont()
                .hidden()
              Color.clear
                .onAppear {
                  canBeExpanded = true
                }
            }
          }
      }
    }
  }
}
