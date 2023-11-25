//
//  GoalSettingView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/23/23.
//

import SwiftUI

struct GoalSettingView: View {
    var goalType: GoalType?
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedDistance: Double = 1.0
    var onGoalSet: () -> Void


    var body: some View {
        VStack() {
            Spacer()
            Text("Set Your Goal").font(.largeTitle).fontWeight(.bold)

            Spacer()
            if goalType == .time {
                DurationPicker(selectedHours: $selectedHours, selectedMinutes: $selectedMinutes)
            } else if goalType == .distance {
                DistanceSlider(selectedDistance: $selectedDistance)
            }

            Spacer()
            Button(action: saveGoalAndContinue) {
                Text("Start My Journey")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }

    private func saveGoalAndContinue() {
        var preferences = UserPreferences(goalType: goalType ?? .distance)
        if goalType == .time {
            preferences.goalDuration = Double(selectedHours * 3600 + selectedMinutes * 60)
        } else if goalType == .distance {
            preferences.goalDistance = selectedDistance
        }
        UserDefaults.standard.userPreferences = preferences
        onGoalSet()
    }
}


struct GoalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSettingView(goalType: .time, onGoalSet: {})
    }
}

