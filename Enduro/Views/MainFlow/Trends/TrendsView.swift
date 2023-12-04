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
        let totalStats = calculateTotalStats(from: filteredRunData)
        NavigationView {
            ScrollView {
                Picker("Time Range", selection: $selectedTimeRange) {
                    Text("Week").tag(TimeRange.week)
                    Text("Month").tag(TimeRange.month)
                    Text("Year").tag(TimeRange.year)
                    Text("All").tag(TimeRange.all)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if (selectedTimeRange != .all) {
                    HStack {
                        Button(action: { adjustReferenceDate(backward: true) }) {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                        Text(dateRangeText())
                        Spacer()
                        Button(action: { adjustReferenceDate(backward: false) }) {
                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding()
                }
                if filteredRunData.isEmpty {
                    Text("No data in the selected range")
                        .padding()
                        .font(.headline)
                } else {
                    statsSection(totalStats)
                    VStack {
                        VStack {
                            Text("Distance").font(.headline)
                            Chart {
                                ForEach(filteredRunData, id: \.date) { runData in
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
                                ForEach(filteredRunData, id: \.date) { runData in
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
                                ForEach(filteredRunData, id: \.date) { runData in
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
                                ForEach(filteredRunData, id: \.date) { runData in
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
            .navigationTitle("Trends")
        }
    }
    private func adjustReferenceDate(backward: Bool) {
        switch selectedTimeRange {
        case .week:
            referenceDate = Calendar.current.date(byAdding: .weekOfYear, value: backward ? -1 : 1, to: referenceDate) ?? referenceDate
        case .month:
            referenceDate = Calendar.current.date(byAdding: .month, value: backward ? -1 : 1, to: referenceDate) ?? referenceDate
        case .year:
            referenceDate = Calendar.current.date(byAdding: .year, value: backward ? -1 : 1, to: referenceDate) ?? referenceDate
        case .all:
            // No adjustment needed for 'All' range
            break
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
    
    private func dateRangeText() -> String {
        let formatter = DateFormatter()
        switch selectedTimeRange {
        case .week:
            formatter.dateFormat = "MMM d"
            let (startOfWeek, endOfWeek) = weekRange(for: referenceDate)
            return "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeek))"
        case .month:
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: referenceDate)
        case .year:
            formatter.dateFormat = "yyyy"
            return formatter.string(from: referenceDate)
        default:
            return ""
        }
    }
}

private func statsSection(_ totalStats: (miles: Double, minutes: Int, runs: Int)) -> some View {
    let statWidth: CGFloat = 100 // Adjust this value as needed

    return VStack {
        Text("Stats").font(.headline)
        HStack {
            VStack {
                Text("\(totalStats.miles, specifier: "%.2f")")
                    .font(.title)
                Text("Miles")
            }
            .frame(width: statWidth)

            VStack {
                Text("\(totalStats.minutes)")
                    .font(.title)
                Text("Minutes")
            }
            .frame(width: statWidth)

            VStack {
                Text("\(totalStats.runs)")
                    .font(.title)
                Text("Runs")
            }
            .frame(width: statWidth)
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

enum TimeRange {
    case week, month, year, all
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

private func weekRange(for date: Date) -> (start: Date, end: Date) {
    let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek)!
    return (startOfWeek, endOfWeek)
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
