//
//  EditLogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI

struct EditLogView: View {
    @ObservedObject var runLog: RunLog
    @State private var timestamp: Date
    var onSave: (RunLog) -> Void

    init(runLog: RunLog, onSave: @escaping (RunLog) -> Void) {
        self.runLog = runLog
        self.onSave = onSave
        _timestamp = State(initialValue: runLog.timestamp ?? Date())
    }

    var body: some View {
        Form {
            DatePicker("Timestamp", selection: $timestamp, displayedComponents: .date)
            TextField("Distance", value: $runLog.distance, format: .number)
            TextField("Duration", value: $runLog.duration, format: .number)
            Button("Save") {
                runLog.timestamp = timestamp
                onSave(runLog)
            }
        }
    }
}
