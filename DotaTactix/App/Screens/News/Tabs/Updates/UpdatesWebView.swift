//
//  UpdatesWebView.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-19.
//

import SwiftUI
import WebKit

struct UpdatesWebView: View {
  @Bindable var viewModel: NewsUpdatesViewModel

  var body: some View {
    ZStack {
      VStack(spacing: 10) {
        HStack {
          HStack(spacing: 30) {
            Button {
              viewModel.goBack()
            } label: {
              Image(systemName: "chevron.backward")
            }
            Button {
              viewModel.goForward()
            } label: {
              Image(systemName: "chevron.forward")
            }
          }

          Spacer()

          Button {
            viewModel.reload()
          } label: {
            Image(systemName: "arrow.clockwise")
          }
        }
        .padding(.horizontal)

        if let url = URL(string: viewModel.patchesURL) {
          VStack(spacing: 0) {
            ZStack {
              BrowserWebView(url: url, viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
              if viewModel.isLoading {
                LoadingView()
              }
            }
          }
        } else {
          Text("Please, enter a url.")
        }
      }
    }
  }
}

#Preview {
  UpdatesWebView(viewModel: NewsUpdatesViewModel())
}
