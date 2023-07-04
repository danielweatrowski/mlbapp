//
//  SwiftMLB+StartingLineups.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import Foundation

extension SwiftMLB {
    static func startingLineups(gameIdentifier: Int) async throws -> MLBBoxscore {
        let request: SwiftMLBRequest = .boxscore(gameIdentifier)

        let data = try await networkService.load(request)
        
        let serializer = SwiftMLBSerialization(data: data, builder: BoxscoreBuilder())
        let boxscoreData = try serializer.data()

        let decoder = JSONDecoder()
        let boxscore = try decoder.decode(MLBBoxscore.self, from: boxscoreData)
        return boxscore
    }
}
