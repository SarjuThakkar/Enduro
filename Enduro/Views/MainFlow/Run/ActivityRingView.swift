//
//  ActivityRingView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/5/23.
//

import SwiftUI

import SwiftUI

struct ActivityRingView: View {
    @Binding var workoutActive: Bool
    var progressResult: ProgressResult
    
    var body: some View {
        ZStack {
            // Outer Ring - Represents the total goal
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.gray)

            // Progress Ring - Fills based on the current progress
            Circle()
                .trim(from: 0, to: min(CGFloat(progressResult.percentage) / 100, 1))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear, value: progressResult.percentage)

            // Progress Text - Shows the current progress in the middle
            Text("30:00")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

// Sample preview
struct ActivityRingView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRingView(
            workoutActive: .constant(true),
            progressResult: ProgressResult(goalType: .distance, goal: 5.0, longest: 3.0, percentage: 60)
        )
    }
}
