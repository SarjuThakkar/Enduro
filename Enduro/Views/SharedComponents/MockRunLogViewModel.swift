//
//  MockRunLogViewModel.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//
import SwiftUI

class MockRunLogViewModel: RunLogViewModel {
    init() {
        super.init(context: PersistenceController.preview.container.viewContext)
    }

    override func addRunLog(timestamp: Date, distance: Double, duration: Double) {
        // Mock implementation, no actual data saving
    }
}
