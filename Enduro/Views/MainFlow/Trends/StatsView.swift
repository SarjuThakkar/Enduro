//
//  StatsView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import SwiftUI

struct StatsView: View {
    let runData: [RunData]
    let statWidth: CGFloat = 100 // Adjust as needed

    var body: some View {
        let totalStats = calculateTotalStats(from: runData)

        VStack {
            Text("Stats").font(.headline)
            HStack {
                StatView(label: "Miles", value: String(format: "%.2f", totalStats.miles), width: statWidth)
                StatView(label: "Minutes", value: "\(totalStats.minutes)", width: statWidth)
                StatView(label: "Runs", value: "\(totalStats.runs)", width: statWidth)
            }
        }
        .padding()
    }

    private func calculateTotalStats(from runData: [RunData]) -> (miles: Double, minutes: Int, runs: Int) {
        let totalMiles = runData.reduce(0) { $0 + $1.totalMiles }
        let totalMinutes = runData.reduce(0) { $0 + $1.totalDuration }
        let totalRuns = runData.reduce(0) { $0 + $1.runCount }
        return (totalMiles, totalMinutes, totalRuns)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample run data for preview
        let sampleRunData = [
            RunData(date: Date(), runCount: 3, totalMiles: 15.5, totalDuration: 120, averagePace: 7.8),
            RunData(date: Date().addingTimeInterval(-86400), runCount: 2, totalMiles: 10.2, totalDuration: 95, averagePace: 9.3)
        ]

        StatsView(runData: sampleRunData)
    }
}
