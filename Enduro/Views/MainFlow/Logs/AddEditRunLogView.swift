//
//  AddEditRunLogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI

struct AddEditRunLogView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RunLogViewModel
    // Optional RunLog for editing
    var runLogToEdit: RunLog?

    // Properties for input fields
    @State private var timestamp: Date
    @State private var distanceString: String = ""
    @State private var selectedHours: Int
    @State private var selectedMinutes: Int
    @State private var selectedSeconds: Int

    private let numberFormatter = OptionalNumberFormatter()
    class OptionalNumberFormatter: NumberFormatter {
        override func string(from number: NSNumber?) -> String? {
            guard let number = number else { return "" }
            return super.string(from: number)
        }
    }
    
    // Computed property for pace
    private var pace: Double {
        guard let distance = Double(distanceString), distance > 0 else { return 0 }
        let totalMinutes = Double(selectedHours * 60 + selectedMinutes) + Double(selectedSeconds) / 60
        return totalMinutes / distance
    }

    init(viewModel: RunLogViewModel, runLogToEdit: RunLog? = nil) {
        self.viewModel = viewModel
        self.runLogToEdit = runLogToEdit

        // Initialize state variables based on whether we are editing an existing log
        if let runLog = runLogToEdit {
            _timestamp = State(initialValue: runLog.timestamp ?? Date())
            _distanceString = State(initialValue: String(runLog.distance))
            let durationInSeconds = Int(runLog.duration)
            _selectedHours = State(initialValue: durationInSeconds / 3600)
            _selectedMinutes = State(initialValue: (durationInSeconds % 3600) / 60)
            _selectedSeconds = State(initialValue: durationInSeconds % 60)
        } else {
            _timestamp = State(initialValue: Date())
            _distanceString = State(initialValue: "")
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
                    TextField("Distance", text: $distanceString)
                        .keyboardType(.decimalPad)
                    Text("miles")
                }
                .onAppear {
                    numberFormatter.numberStyle = .decimal
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
                    let distance = Double(distanceString) ?? 0
                    let durationInSeconds = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
                    if let runLog = runLogToEdit {
                        runLog.timestamp = timestamp
                        runLog.distance = distance
                        runLog.duration = Int32(durationInSeconds)
                        runLog.pace = pace
                        viewModel.updateRunLog(runLog)
                    } else {
                        viewModel.addRunLog(timestamp: timestamp, distance: distance, duration: Int32(durationInSeconds), pace: pace)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle(runLogToEdit == nil ? "Record Run" : "Edit Run")
        }
    }
}

struct AddDurationPicker: View {
    @Binding var selectedHours: Int
    @Binding var selectedMinutes: Int
    @Binding var selectedSeconds: Int

    var body: some View {
        HStack {
            Picker("Hours", selection: $selectedHours) {
                ForEach(0..<24) { Text("\($0) hr").tag($0) }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80)

            Picker("Minutes", selection: $selectedMinutes) {
                ForEach(0..<60) { Text("\($0) min").tag($0) }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80)

            Picker("Seconds", selection: $selectedSeconds) {
                ForEach(0..<60) { Text("\($0) sec").tag($0) }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80)
        }
    }
}


struct AddEditRunLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditRunLogView(viewModel: MockRunLogViewModel())
    }
}
