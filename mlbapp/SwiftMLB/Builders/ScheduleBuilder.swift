//
//  ScheduleParser.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/8/23.
//

import Foundation

struct ScheduleBuilder: JSONBuilder {
    func build(with data: Data) throws -> [String : Any] {
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
        
        return [
            "games": allGames
        ]
    }
}
