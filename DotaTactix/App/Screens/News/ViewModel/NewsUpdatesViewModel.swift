//
//  NewsViewModel.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-18.
//

import SwiftUI
import WebKit

enum NewsTabs: String, CaseIterable { case news = "News"; case updates = "Updates" }

@Observable
class NewsUpdatesViewModel: NSObject, WKNavigationDelegate {
  var currentTab: NewsTabs = .news
  var isNewsLoading = false
  var isLoading = false
  var tabTitle: String = "News"
  var showAlert = false
  var error = "" {
    didSet {
      showAlert = !error.isEmpty
    }
  }

  var news: [NewsItem] = []

  func fetchNews() async {
    isNewsLoading = true
    defer {
      isNewsLoading = false
    }
    do {
      news = try await NewsManager().fetchNews(count: 30)
    } catch {
      self.error = error.localizedDescription
    }
  }

  var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, h:mm a"

    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    dateFormatter.doesRelativeDateFormatting = true

    return dateFormatter
  }

  var patchesURL = "https://www.dota2.com/patches"
  weak var webView: WKWebView?

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
    isLoading = true
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
    isLoading = false
  }

  func goBack() {
    webView?.goBack()
  }

  func goForward() {
    webView?.goForward()
  }

  func reload() {
    webView?.reload()
  }
}

// MARK: - Build Webview

struct BrowserWebView: UIViewRepresentable {
  let url: URL
  var viewModel: NewsUpdatesViewModel

  func makeUIView(context: Context) -> WKWebView {
    let config = WKWebViewConfiguration()
    let pref = WKWebpagePreferences()

    pref.preferredContentMode = .mobile
    config.defaultWebpagePreferences = pref

    let webView = WKWebView(frame: CGRect.zero, configuration: config)

    webView.scrollView.showsVerticalScrollIndicator = false
    webView.scrollView.showsHorizontalScrollIndicator = false
    webView.navigationDelegate = viewModel

    viewModel.webView = webView

    return webView
  }

  func updateUIView(_ uiView: WKWebView, context: Context) {
    let request = URLRequest(url: url)
    uiView.load(request)
  }
}
