//
//  SwiftMLB+Plays.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/14/23.
//

import Foundation

extension SwiftMLB {
    
    static func plays(for gameID: Int) async throws -> MLBPlays {
        let request: SwiftMLBRequest = .plays(gameID)
        let data = try await networkService.load(request)
        
        let serializer = SwiftMLBSerialization(data: data, builder: PlaysBuilder())
        let playsData = try serializer.data()
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let plays = try decoder.decode(MLBPlays.self, from: playsData)
        
        return plays
    }
    
}
