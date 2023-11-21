//
//  EnduroApp.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/21/23.
//

import SwiftUI

@main
struct EnduroApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
