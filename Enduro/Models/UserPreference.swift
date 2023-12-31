//
//  UserPreference.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/22/23.
//

import Foundation

enum GoalType: String, Codable, Hashable {
    case time = "Time"
    case distance = "Distance"
}

struct UserPreferences: Codable {
    var goalType: GoalType
    var goalDistance: Double?
    var goalDuration: Int32? // Duration in seconds
}

