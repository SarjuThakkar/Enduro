//
//  EditLogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI
import CoreData

struct EditLogView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RunLogViewModel
    var runLog: RunLog

    @State private var timestamp: Date
    @State private var distance: Double
    @State private var duration: Double

    init(viewModel: RunLogViewModel, runLog: RunLog) {
        self.viewModel = viewModel
        self.runLog = runLog

        _timestamp = State(initialValue: runLog.timestamp!)
        _distance = State(initialValue: runLog.distance)
        _duration = State(initialValue: runLog.duration)
    }

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Timestamp", selection: $timestamp, displayedComponents: .date)
                TextField("Distance", value: $distance, format: .number)
                TextField("Duration", value: $duration, format: .number)
                
                Button("Save") {
                    runLog.timestamp = timestamp
                    runLog.distance = distance
                    runLog.duration = duration
                    viewModel.updateRunLog(runLog)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("View/Edit Run")
        }
    }
}


struct EditLogView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext

        let sampleRunLog = RunLog(context: context)
        sampleRunLog.timestamp = Date()
        sampleRunLog.distance = 5.0
        sampleRunLog.duration = 30.0

        return EditLogView(viewModel: MockRunLogViewModel(), runLog: sampleRunLog)
        .environment(\.managedObjectContext, context)
    }
}

