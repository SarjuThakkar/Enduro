//
//  TimeRangeSelectorView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import SwiftUI

struct TimeRangeSelectorView: View {
    @Binding var selectedTimeRange: TimeRange
    
    var body: some View {
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

#Preview {
    TimeRangeSelectorView()
}
