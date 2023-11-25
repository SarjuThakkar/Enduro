//
//  LogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI

struct LogView: View {
    @Environment(\.managedObjectContext) private var context
    @State private var showingAddRunLog = false
    @State private var selectedRunLog: RunLog?
    @State private var showingEditLogView = false

    private var viewModel: RunLogViewModel {
        RunLogViewModel(context: context)
    }
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RunLog.timestamp, ascending: false)],
        animation: .default)
    private var runLogs: FetchedResults<RunLog>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(runLogs, id: \.self) { log in
                    Button(action: {
                        selectedRunLog = log
                        showingEditLogView = true
                    }) {
                        Text("Run on \(log.timestamp ?? Date(), formatter: dateFormatter)")
                    }
                }
                .onDelete(perform: deleteRunLog)
            }
            .navigationTitle("Run Logs")
            .navigationBarItems(trailing: Button(action: {
                showingAddRunLog = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddRunLog) {
                AddRunLogView()
            }
            .sheet(isPresented: $showingEditLogView) {
                if let runLog = selectedRunLog {
                    EditLogView(runLog: runLog) { updatedLog in
                        viewModel.updateRunLog(updatedLog)
                        showingEditLogView = false
                    }
                }
            }
        }
    }

    private func deleteRunLog(at offsets: IndexSet) {
        offsets.forEach { index in
            let runLog = runLogs[index]
            viewModel.deleteRunLog(runLog)
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}
