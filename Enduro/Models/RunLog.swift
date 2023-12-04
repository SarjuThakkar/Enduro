//
//  RunLog.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import Foundation
import SwiftData

@Model
final class RunLog {
    var timestamp: Date
    var distance: Double
    var duration: Int32
    var pace: Double

    init(timestamp: Date, distance: Double, duration: Int32, pace: Double) {
        self.timestamp = timestamp
        self.distance = distance
        self.duration = duration
        self.pace = pace
    }
}
