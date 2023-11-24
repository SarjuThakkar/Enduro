//
//  EnduroApp.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/21/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var hasCompletedWelcomeFlow: Bool = false
}

@main
struct EnduroApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.hasCompletedWelcomeFlow || UserDefaults.standard.userPreferences != nil {
                MainView()
            } else {
                WelcomeView(appState: appState)
            }
        }
    }
}

