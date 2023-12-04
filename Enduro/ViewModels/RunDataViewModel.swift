//
//  RunDataViewModel.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/3/23.
//

import Foundation
import CoreData
import Combine

class RunDataViewModel: ObservableObject {
    @Published var runData: [RunData] = []
    private var context: NSManagedObjectContext?

    func setContext(_ context: NSManagedObjectContext) {
        self.context = context
    }

    func updateRunData() {
        guard let context = context else { return }
        let request: NSFetchRequest<RunLog> = RunLog.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RunLog.timestamp, ascending: true)]
        if let runLogs = try? context.fetch(request) {
            self.runData = groupRunsByDay(runs: runLogs)
        }
    }
    
    private func groupRunsByDay(runs: [RunLog]) -> [RunData] {
        let grouped = Dictionary(grouping: runs, by: { Calendar.current.startOfDay(for: $0.timestamp!) })
        return grouped.map { (date, runs) -> RunData in
            let totalMiles = runs.reduce(0) { $0 + $1.distance }
            let totalDuration = runs.reduce(0) { $0 + Int($1.duration) / 60 } // Convert seconds to minutes
            let averagePace = runs.count > 1 ? runs.reduce(0) { $0 + $1.pace } / Double(runs.count) : (runs.first?.pace ?? 0)
            
            return RunData(date: date, runCount: runs.count, totalMiles: totalMiles, totalDuration: totalDuration, averagePace: averagePace)
        }.sorted(by: { $0.date < $1.date })
    }
}

struct RunData {
    let date: Date
    let runCount: Int
    let totalMiles: Double
    let totalDuration: Int // duration in minutes
    let averagePace: Double // minutes per mile
}

