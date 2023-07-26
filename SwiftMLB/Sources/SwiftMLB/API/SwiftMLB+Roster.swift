//
//  SwiftMLB+Roster.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

public extension SwiftMLB {
    static func roster(paramters: SwiftMLBRequest.RosterParameters) async throws -> MLBRoster {
        let request: SwiftMLBRequest = .roster(paramters)

        let data = try await networkService.load(request)

        let serializer = SwiftMLBSerialization(data: data, builder: PassThruBuilder())
        let rosterData = try serializer.data()

        let decoder = JSONDecoder()
        let roster = try decoder.decode(MLBRoster.self, from: rosterData)
        return roster
    }
}
