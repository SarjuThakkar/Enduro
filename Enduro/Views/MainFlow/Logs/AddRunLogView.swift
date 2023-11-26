//
//  AddRunLogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI

struct AddRunLogView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RunLogViewModel

    @State private var timestamp = Date()
    @State private var distance: Double = 0
    @State private var duration: Double = 0

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $timestamp)
                TextField("Distance (miles)", value: $distance, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Duration (minutes)", value: $duration, format: .number)
                    .keyboardType(.decimalPad)
                
                Button("Save") {
                    viewModel.addRunLog(timestamp: timestamp, distance: distance, duration: duration)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Record Run")
        }
    }
}

struct AddRunLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddRunLogView(viewModel: MockRunLogViewModel())
    }
}

