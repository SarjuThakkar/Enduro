//
//  TrendsView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI
import Charts
import SwiftData

struct TrendsView: View {
    @Query private var runLogs: [RunLog]
    @State private var selectedTimeRange: TimeRange = .week
    @State private var referenceDate: Date = Date()

    var body: some View {
        let filteredRunData = groupRunsByDay(runs: runLogs.filter { runLog in
            isDate(runLog.timestamp, inTimeRange: selectedTimeRange, relativeTo: referenceDate)
        })
        NavigationView {
            ScrollView {
                TimeRangeSelectorView(
                   selectedTimeRange: $selectedTimeRange,
                   referenceDate: $referenceDate
               )
                if filteredRunData.isEmpty {
                    Text("No data in the selected range")
                        .padding()
                        .font(.headline)
                } else {
                    StatsView(runData: filteredRunData)
                    ChartsView(runData: filteredRunData)
                }
            }
            .navigationTitle("Trends")
        }
    }
    private func isDate(_ date: Date, inTimeRange timeRange: TimeRange, relativeTo referenceDate: Date) -> Bool {
        switch timeRange {
        case .week:
            return Calendar.current.isDate(date, equalTo: referenceDate, toGranularity: .weekOfYear)
        case .month:
            return Calendar.current.isDate(date, equalTo: referenceDate, toGranularity: .month)
        case .year:
            return Calendar.current.isDate(date, equalTo: referenceDate, toGranularity: .year)
        case .all:
            return true
        }
    }
}

extension Calendar {
    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
    }

    func isDateInThisMonth(_ date: Date) -> Bool {
        return isDate(date, equalTo: Date(), toGranularity: .month)
    }

    func isDateInThisYear(_ date: Date) -> Bool {
        return isDate(date, equalTo: Date(), toGranularity: .year)
    }
}

private func groupRunsByDay(runs: [RunLog]) -> [RunData] {
    let grouped = Dictionary(grouping: runs, by: { Calendar.current.startOfDay(for: $0.timestamp) })
    return grouped.map { (date, runs) -> RunData in
        let totalMiles = runs.reduce(0) { $0 + $1.distance }
        let totalDuration = runs.reduce(0) { $0 + Int($1.duration) / 60 } // Convert seconds to minutes
        
        let averagePace: Double
        if totalMiles > 0 {
            averagePace = Double(totalDuration) / totalMiles
        } else {
            averagePace = 0
        }
        
        return RunData(date: date, runCount: runs.count, totalMiles: totalMiles, totalDuration: totalDuration, averagePace: averagePace)
    }.sorted(by: { $0.date < $1.date })
}

struct TrendsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendsView()
    }
}
