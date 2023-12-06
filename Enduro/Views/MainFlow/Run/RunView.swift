//
//  RunView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI
import SwiftData
import Foundation

struct RunView: View {
    @Query private var runLogs: [RunLog]
    @EnvironmentObject var appState: AppState

    @State private var workoutActive: Bool = false // State to track if workout is active
    
    var body: some View {
        let goalData = calculateGoalData(userPreferences: UserDefaults.standard.userPreferences, runLogs: runLogs)
        
        NavigationView {
            VStack {
                VStack {
                    GoalProgressBar(progressResult: goalData)
                    HStack {
                        Text("Goal: \(goalDisplayString(goalData))")
                        Spacer()
                        Button("Update Goal") {
                            // Reset the welcome flow state
                            appState.hasCompletedWelcomeFlow = false
                            UserDefaults.standard.userPreferences = nil
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                ActivityRingView(workoutActive: $workoutActive, progressResult: goalData)
                
                Spacer()
            }
            .navigationTitle("Run")
        }
    }
    
    private func startWorkout() {
       // Logic to start workout...
       workoutActive = true
    }

    private func goalDisplayString(_ goalData: ProgressResult) -> String {
        switch goalData.goalType {
        case .time:
            return formatDuration(goalData.goal)
        case .distance:
            return "\(goalData.goal) miles"
        }
    }

    private func formatDuration(_ seconds: Double) -> String {
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        return "\(hours)h \(minutes)m"
    }
}

struct ProgressResult {
    var goalType: GoalType
    var goal: Double
    var longest: Double
    var percentage: Int
}

func calculateGoalData(userPreferences: UserPreferences?, runLogs: [RunLog]) -> ProgressResult {
    guard let preferences = userPreferences else {
        // Default values when no preferences are set
        return ProgressResult(goalType: .time, goal: 0, longest: 0, percentage: 0)
    }

    switch preferences.goalType {
    case .time:
        let goalDuration = Double(preferences.goalDuration ?? 0)
        let longestRunDuration = Double(longestDuration(from: runLogs))
        let percentage = goalDuration > 0 ? Int((longestRunDuration / goalDuration) * 100) : 0
        return ProgressResult(goalType: .time, goal: goalDuration, longest: longestRunDuration, percentage: percentage)

    case .distance:
        let goalDistance = preferences.goalDistance ?? 0.0
        let longestRunDistance = longestDistance(from: runLogs)
        let percentage = goalDistance > 0 ? Int((longestRunDistance / goalDistance) * 100) : 0
        return ProgressResult(goalType: .distance, goal: goalDistance, longest: longestRunDistance, percentage: percentage)
    }
}

func longestDuration(from runLogs: [RunLog]) -> Int32 {
    guard let longestRun = runLogs.max(by: { $0.duration < $1.duration }) else {
        // If there are no run logs, return 0
        return 0
    }
    return longestRun.duration
}

func longestDistance(from runLogs: [RunLog]) -> Double {
    guard let longestRun = runLogs.max(by: { $0.distance < $1.distance }) else {
        // If there are no run logs, return 0
        return 0.0
    }
    return longestRun.distance
}

struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        RunView()
    }
}

