//
//  SwiftMLB+PlayEventType.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import Foundation

extension SwiftMLB {
    static func eventTypes() async throws -> [MLBPlay.EventType] {
        let request: SwiftMLBRequest = .meta("eventType")

        let data = try await networkService.load(request)
        let decoder = JSONDecoder()
        let events = try decoder.decode([MLBPlay.EventType].self, from: data)
        
        return events
    }
}
