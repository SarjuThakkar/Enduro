//
//  RunLogViewModel.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import Foundation
import CoreData

class RunLogViewModel: ObservableObject {

    // Reference to the managed object context
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func addRunLog(timestamp: Date, distance: Double, duration: Int32, pace: Double) {
        let newLog = RunLog(context: context)
        newLog.timestamp = timestamp
        newLog.distance = distance
        newLog.duration = duration
        newLog.pace = pace
        saveContext()
    }
    
    func updateRunLog(_ updatedLog: RunLog) {
        // Assuming timestamp, distance, and duration are the only editable fields
        if context.hasChanges {
            saveContext()
        }
    }


    func deleteRunLog(_ log: RunLog) {
        context.delete(log)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

