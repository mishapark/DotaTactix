//
//  DotaTactixApp.swift
//  DotaTactix
//
//  Created by Mikhail Pak on 2023-12-16.
//

import SwiftUI

@main
struct DotaTactixApp: App {
  @StateObject private var manager: CoreDataManager = .init()
  @State private var showLaunchAnimation = true

  var body: some Scene {
    WindowGroup {
      ZStack {
        RootView()
          .environmentObject(manager)
          .environment(\.managedObjectContext, manager.container.viewContext)

        if showLaunchAnimation {
          LaunchAnimation(showLaunchAnimation: $showLaunchAnimation)
            .transition(.move(edge: .leading))
        }
      }
    }
  }
}

struct LaunchAnimation: View {
  @Binding var showLaunchAnimation: Bool

  @State private var logoScale: CGFloat = 1

  var body: some View {
    ZStack {
      Image(.launchBackground)
        .scaledToFill()

      Image(.dtlogo)
        .resizable()
        .scaledToFit()
        .frame(maxWidth: logoScale)
    }
    .onAppear {
      withAnimation(.interpolatingSpring(stiffness: 300, damping: 15)) {
        logoScale = 200
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        showLaunchAnimation = false
      }
    }
  }
}
