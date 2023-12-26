//
//  NewsCardView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-24.
//

import SwiftUI

struct NewsCardView: View {
  var viewModel: NewsUpdatesViewModel
  var news: NewsItem

  var body: some View {
    VStack(spacing: 10) {
      HStack(alignment: .top) {
        Text(news.title)
          .boldFont(size: 18)
          .lineLimit(3)
          .minimumScaleFactor(0.75)
        Spacer()
        if let url = URL(string: news.url) {
          Link(destination: url) {
            Image(.link)
              .resizable()
              .renderingMode(.template)
              .scaledToFit()
              .frame(width: 20, height: 20)
              .padding(.leading, 5)
          }
        }
      }
      HStack {
        Text(news.feedlabel)
          .boldFont(size: 15, color: .accent)
        Spacer()
      }
      HStack {
        if !news.author.isEmpty {
          HStack(spacing: 0) {
            Text("Author: ")
              .thinFont(size: 15)
            Text("\(news.author)")
              .boldFont(size: 15, color: .accent)
          }
        }
        Spacer()
        Text(
          viewModel.dateFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(news.date))
          )
        )
        .thinFont(size: 15)
      }
    }
    .card(padding: 20)
  }
}
