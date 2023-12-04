//
//  TimeRangeSelectorView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import SwiftUI

struct TimeRangeSelectorView: View {
    @Binding var selectedTimeRange: TimeRange
    @Binding var referenceDate: Date
    
    var body: some View {
        VStack {
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

enum TimeRange {
    case week, month, year, all
}

private func weekRange(for date: Date) -> (start: Date, end: Date) {
    let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek)!
    return (startOfWeek, endOfWeek)
}


struct TimeRangeSelector_Previews: PreviewProvider {
    @State static var previewSelectedTimeRange: TimeRange = .week
    @State static var previewReferenceDate: Date = Date()

    static var previews: some View {
        TimeRangeSelectorView(selectedTimeRange: $previewSelectedTimeRange, referenceDate: $previewReferenceDate)
    }
}

