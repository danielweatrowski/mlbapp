//
//  MLBRequestParameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/18/22.
//

import Foundation

public extension SwiftMLBRequest {
    struct ScheduleParameters {
        var startDate: Date?
        var endDate: Date?
        var teamIdentifier: String?
        var opponentIdentifier: String?
        var gameType: String?
    }
    
    struct PersonParameters {
        
        struct HydrateParameters {
            
            enum GroupType: String {
                case hitting, pitching, fielding
            }
            
            enum StatType: String {
                case career, season, yearByYear
            }
            
            var group: [GroupType]
            var type: [StatType]
        }
        
        var personIdentifier: Int
        var hydrate: HydrateParameters?
        
        func toQueryItems() -> [URLQueryItem] {
            guard let hydrate = hydrate else {
                return [URLQueryItem(name: "hydrate", value: nil)]
            }
            
            var groupString = ""
            if !hydrate.group.isEmpty {
                // ie. group=[hitting,pitching,fielding]
                let values = hydrate.group.map({$0.rawValue}).joined(separator: ",")
                groupString = "group=[\(values)]"
            }
            
            var typeString = ""
            if !hydrate.type.isEmpty {
                // type=[season,career,yearByYear]
                let values = hydrate.type.map({$0.rawValue}).joined(separator: ",")
                typeString = "type=[\(values)]"
            }
            
            // if at least one has values, hydrate stats
            var statString = ""
            if !typeString.isEmpty && !groupString.isEmpty {
                // ie. stats(group=[hitting,pitching,fielding],type=[season,career,yearByYear])
                let values = [groupString, typeString].joined(separator: ",")
                statString = "stats(\(values))"
            }
            
            // ie. stats(group=[hitting,pitching,fielding],type=[season,career,yearByYear]),currentTeam
            let value = [statString, "currentTeam"].joined(separator: ",")
            
            return [URLQueryItem(name: "hydrate", value: value)]
        }
    }
}
