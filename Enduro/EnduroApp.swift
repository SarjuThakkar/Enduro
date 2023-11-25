//
//  EnduroApp.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/21/23.
//

import SwiftUI
import CoreData

class AppState: ObservableObject {
    @Published var hasCompletedWelcomeFlow: Bool = false
}

@main
struct EnduroApp: App {
    @StateObject var appState = AppState()

    // Initialize the persistent container
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Enduro")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var body: some Scene {
        WindowGroup {
            if appState.hasCompletedWelcomeFlow || UserDefaults.standard.userPreferences != nil {
                HomeView()
                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            } else {
                WelcomeView(appState: appState)
                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            }
        }
    }
}

