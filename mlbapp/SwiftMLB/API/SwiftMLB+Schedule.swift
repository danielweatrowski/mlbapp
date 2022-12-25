//
//  SwiftMLB+GameLookup.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation
import Combine

public extension SwiftMLB {
    
    static func schedule(parameters: SwiftMLBRequest.ScheduleParameters) async throws -> [[String: Any]] {
        let request: SwiftMLBRequest = .schedule(parameters)
        let data = try await networkService.load(request)

        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        
        guard let dates = dict["dates"] as? [[String: Any]] else {
            throw SwiftMLBError.keyNotFound(key: "dates")
        }
        
        var allGames = [[String: Any]]()
        for date in dates {
            guard let games = date["games"] as? [[String: Any]] else {
                throw SwiftMLBError.keyNotFound(key: "games")
            }
            
            for game in games {
                allGames.append(game)
            }
        }
        return allGames
    }
}
