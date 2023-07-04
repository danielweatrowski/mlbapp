//
//  SwiftMLB+GameLookup.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation
import Combine

public extension SwiftMLB {
    
    static func scheduleData(parameters: SwiftMLBRequest.ScheduleParameters) async throws -> [String: Any] {
        let request: SwiftMLBRequest = .schedule(parameters)
        let data = try await networkService.load(request)

        let serializer = SwiftMLBSerialization(data: data, builder: ScheduleBuilder())
        let schedule = try serializer.jsonObject()
        
        return schedule
    }
}
