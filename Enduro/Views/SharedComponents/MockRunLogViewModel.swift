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
}
