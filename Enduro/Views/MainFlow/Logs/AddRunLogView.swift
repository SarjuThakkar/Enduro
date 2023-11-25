//
//  AddRunLogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI

struct AddRunLogView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var context

    @State private var timestamp = Date()
    @State private var distance: Double = 0
    @State private var duration: Double = 0

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Timestamp", selection: $timestamp)
                TextField("Distance (miles)", value: $distance, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Duration (minutes)", value: $duration, format: .number)
                    .keyboardType(.decimalPad)
                
                Button("Save") {
                    let newLog = RunLog(context: context)
                    newLog.timestamp = timestamp
                    newLog.distance = distance
                    newLog.duration = duration

                    do {
                        try context.save()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Error saving context: \(error)")
                    }
                }
            }
            .navigationTitle("Add Run Log")
        }
    }
}

