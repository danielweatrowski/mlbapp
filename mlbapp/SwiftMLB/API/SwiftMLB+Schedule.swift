//
//  SwiftMLB+Schedule.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import Foundation

extension SwiftMLB {
    
    static func schedule(parameters: SwiftMLBRequest.ScheduleParameters) async throws -> Schedule {
        let request: SwiftMLBRequest = .schedule(parameters)
        let data = try await networkService.load(request)

        let serializer = SwiftMLBSerialization(data: data, builder: ScheduleBuilder())
        let scheduleData = try serializer.data()
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let schedule = try decoder.decode(Schedule.self, from: scheduleData)
        
        return schedule
    }
}
