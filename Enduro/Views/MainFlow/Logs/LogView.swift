//
//  LogView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI
import SwiftData

struct LogView: View {
    @Query(sort: \RunLog.timestamp, order: .reverse) private var runLogs: [RunLog]
    @State private var showingAddRunLog = false
    @State private var selectedRunLog: RunLog?
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            List {
                ForEach(runLogs, id: \.self) { log in
                    Button(action: {
                        selectedRunLog = log
                    }) {
                        Text("Run on \(log.timestamp, formatter: dateFormatter)")
                    }
                }
                .onDelete(perform: deleteRunLog)
            }
            .navigationTitle("Logs")
            .navigationBarItems(trailing: Button(action: {
                showingAddRunLog = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddRunLog) {
                AddEditRunLogView()
            }
            .sheet(item: $selectedRunLog) { runLog in
                AddEditRunLogView(runLogToEdit: runLog)
            }
        }
    }
    

    private func deleteRunLog(at offsets: IndexSet) {
        offsets.forEach { index in
            let runLog = runLogs[index]
            modelContext.delete(runLog)
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    LogView()
}
