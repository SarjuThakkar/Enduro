//
//  AddEditRunLogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI

struct AddEditRunLogView: View {
    @Environment(\.presentationMode) var presentationMode
    // Optional RunLog for editing
    var runLogToEdit: RunLog?
    @Environment(\.modelContext) private var modelContext

    // Properties for input fields
    @State private var timestamp: Date
    @State private var selectedDistance: Double
    @State private var selectedHours: Int
    @State private var selectedMinutes: Int
    @State private var selectedSeconds: Int
    
    // Computed property for pace
    private var pace: Double {
        let totalMinutes = Double(selectedHours * 60 + selectedMinutes) + Double(selectedSeconds) / 60
        if selectedDistance > 0 {
            return totalMinutes / selectedDistance
        } else {
            return 0
        }

    }
    
    init(runLogToEdit: RunLog? = nil) {
            self.runLogToEdit = runLogToEdit
            // Initialize state variables based on whether we are editing an existing log
            if let runLog = runLogToEdit {
                _timestamp = State(initialValue: runLog.timestamp)
                _selectedDistance = State(initialValue: runLog.distance)
                let durationInSeconds = Int(runLog.duration)
                _selectedHours = State(initialValue: durationInSeconds / 3600)
                _selectedMinutes = State(initialValue: (durationInSeconds % 3600) / 60)
                _selectedSeconds = State(initialValue: durationInSeconds % 60)
            } else {
                _timestamp = State(initialValue: Date())
                _selectedDistance = State(initialValue: 0)
                _selectedHours = State(initialValue: 0)
                _selectedMinutes = State(initialValue: 0)
                _selectedSeconds = State(initialValue: 0)
            }
        }

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Image(systemName: "calendar")
                    DatePicker("Date", selection: $timestamp)
                }
                
                HStack {
                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                    TextField("Distance", value: $selectedDistance, format: .number)
                        .keyboardType(.decimalPad)
                    Text("miles")
                }
                
                HStack {
                    Image(systemName: "clock")
                    AddDurationPicker(selectedHours: $selectedHours, selectedMinutes: $selectedMinutes, selectedSeconds: $selectedSeconds)
                }
                
                HStack {
                    Image(systemName: "hare")
                    Text(String(format: "%.2f min/mile", pace))
                }

                Button(runLogToEdit == nil ? "Save" : "Update") {
                    let durationInSeconds = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
                    if let runLog = runLogToEdit {
                        runLog.timestamp = timestamp
                        runLog.distance = selectedDistance
                        runLog.duration = Int32(durationInSeconds)
                        runLog.pace = pace
                    } else {
                        let newRunLog = RunLog(timestamp: timestamp, distance: selectedDistance, duration: Int32(durationInSeconds), pace: pace)
                        modelContext.insert(newRunLog)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle(runLogToEdit == nil ? "Record Run" : "Edit Run")
        }
    }
}

#Preview {
    AddEditRunLogView()
}
