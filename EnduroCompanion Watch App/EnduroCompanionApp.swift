//
//  EnduroCompanionApp.swift
//  EnduroCompanion Watch App
//
//  Created by Sarju Thakkar on 12/7/23.
//

import SwiftUI

@main
struct EnduroCompanion_Watch_App: App {
    @StateObject private var workoutManager = WorkoutManager()

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
        }
    }
}
