//
//  ChartsView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import SwiftUI
import Charts

struct ChartsView: View {
    var runData: [RunData]

    var body: some View {
        VStack {
            VStack {
                Text("Distance").font(.headline)
                Chart {
                    ForEach(runData, id: \.date) { runData in
                        LineMark(
                            x: .value("Date", runData.date, unit: .day),
                            y: .value("Miles", runData.totalMiles)
                        )
                    }
                }
                .chartYAxisLabel("miles")
            }
            .padding()
            
            VStack {
                Text("Duration").font(.headline)
                Chart {
                    ForEach(runData, id: \.date) { runData in
                        LineMark(
                            x: .value("Date", runData.date, unit: .day),
                            y: .value("Duration", runData.totalDuration)
                        )
                    }
                }
                .chartYAxisLabel("minutes")
            }
            .padding()
            
            VStack {
                Text("Pace").font(.headline)
                Chart {
                    ForEach(runData, id: \.date) { runData in
                        LineMark(
                            x: .value("Date", runData.date, unit: .day),
                            y: .value("Pace", runData.averagePace)
                        )
                    }
                }
                .chartYAxisLabel("mins/mile")
            }
            .padding()
            
            VStack {
                Text("Run Count").font(.headline)
                Chart {
                    ForEach(runData, id: \.date) { runData in
                        LineMark(
                            x: .value("Date", runData.date, unit: .day),
                            y: .value("Runs", runData.runCount)
                        )
                    }
                }
            }
            .padding()
        }
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide sample data for preview
        let sampleRunData = [
            RunData(date: Date(), runCount: 3, totalMiles: 15.5, totalDuration: 120, averagePace: 7.8),
            RunData(date: Date().addingTimeInterval(-86400), runCount: 2, totalMiles: 10.2, totalDuration: 95, averagePace: 9.3)
        ]

        ChartsView(runData: sampleRunData)
    }
}

