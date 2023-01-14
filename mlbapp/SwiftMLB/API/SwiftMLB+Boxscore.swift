//
//  SwiftMLB+Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

extension SwiftMLB {
    static func boxscore(gameIdentifier: Int) async throws -> Boxscore {
        let request: SwiftMLBRequest = .boxscore(gameIdentifier)

        let data = try await networkService.load(request)
        
        let serializer = SwiftMLBSerialization(data: data, builder: BoxscoreBuilder())
        let boxscoreData = try serializer.data()

        let decoder = JSONDecoder()
        let boxscore = try decoder.decode(Boxscore.self, from: boxscoreData)
        return boxscore
    }
}
