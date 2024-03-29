//
//  SwiftMLB+ScoringPlays.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/9/22.
//

import Foundation

extension SwiftMLB {
    
    static func gameScoringPlayData(for gameID: Int) async throws -> [String: Any] {
        let request: SwiftMLBRequest = .scoringPlays(gameID)
        let data = try await networkService.load(request)
        
        let serializer = SwiftMLBSerialization(data: data, builder: GameScoringPlayBuilder())
        let plays = try serializer.jsonObject()
        
        return plays
    }
}


