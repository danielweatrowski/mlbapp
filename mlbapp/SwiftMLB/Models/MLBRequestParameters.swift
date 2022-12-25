//
//  MLBRequestParameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/18/22.
//

import Foundation

public extension SwiftMLBRequest {
    struct ScheduleParameters {
        var startDate: Date?
        var endDate: Date?
        var teamIdentifier: String?
        var opponentIdentifier: String?
        var gameType: String?
    }
}
