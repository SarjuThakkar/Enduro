//
//  EnduroApp.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/21/23.
//

import SwiftUI

@main
struct EnduroApp: App {
    var body: some Scene {
        WindowGroup {
           Group {
               if UserDefaults.standard.userPreferences != nil {
                   // Your main view if preferences are set
                   MainView()
               } else {
                   // Show the welcome view if no preferences are set
                   WelcomeView()
               }
           }
       }
    }
}
