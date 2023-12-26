//
//  HeroAboutView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-17.
//

import SwiftUI

struct HeroAboutView: View {
  var bio: String
  var shortBio: String

  @State private var isFull = false

  var body: some View {
    ZStack {
      HStack {
        Spacer()
        Image(.dotaLogo)
          .resizable()
          .scaledToFit()
          .frame(width: 150)
          .saturation(0.2)
          .opacity(0.5)
      }
      VStack(alignment: .leading) {
        HStack(spacing: 20) {
          Text("About")
            .blackFont(size: 20)

          Button {
            withAnimation {
              isFull.toggle()
            }
          } label: {
            Text(isFull ? "Close History" : "Read Full History")
              .boldFont(size: 15, color: .accent)
              .underline()
          }
          Spacer()
        }
        .padding(.bottom, 5)
        Text(isFull ? bio.stripHTML : shortBio.stripHTML)
          .regularFont()
        Spacer()
      }
    }
    .card(padding: 15)
  }
}

#Preview {
  HeroAboutView(bio: MockData.hero.bio, shortBio: MockData.hero.shortBio)
}
