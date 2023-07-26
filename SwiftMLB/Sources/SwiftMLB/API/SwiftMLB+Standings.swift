//
//  SwiftMLB+Standings.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation


public extension SwiftMLB {
    static func standings(paramters: SwiftMLBRequest.StandingsParameters) async throws -> MLBStandings {
        let request: SwiftMLBRequest = .standings(paramters)

        let data = try await networkService.load(request)

        let serializer = SwiftMLBSerialization(data: data, builder: PassThruBuilder())
        let standingsData = try serializer.data()

        let decoder = JSONDecoder()
        let standings = try decoder.decode(MLBStandings.self, from: standingsData)
        return standings
    }
}
