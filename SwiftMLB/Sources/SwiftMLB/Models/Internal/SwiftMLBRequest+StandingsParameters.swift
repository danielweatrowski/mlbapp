//
//  SwiftMLBRequest+StandingsParameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation

public extension SwiftMLBRequest {
    struct StandingsParameters {
        
        public init(date: Date, league: SwiftMLBRequest.StandingsParameters.League = .all, standingsType: String = "regularSeason") {
            self.date = date
            self.league = league
            self.standingsType = standingsType
        }
        
        
        public enum League: Int {
            case all
            case american = 103
            case national = 104
        }
        
        let date: Date
        var league: League = .all
        var standingsType: String = "regularSeason"
        
        
        func toQueryParameters() -> [URLQueryItem] {
            
            var items = [URLQueryItem]()
            
            switch league {
            case .all:
                items.append(URLQueryItem(name: "leagueId", value: "103,104"))
            case .american:
                items.append(URLQueryItem(name: "leagueId", value: "103"))
            case .national:
                items.append(URLQueryItem(name: "leagueId", value: "104"))
            }
            
            items.append(URLQueryItem(name: "standingsType", value: standingsType))
            items.append(URLQueryItem(name: "date", value: date.formatted(date: .numeric, time: .omitted)))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            let yearString = dateFormatter.string(from: date)
            
            items.append(URLQueryItem(name: "season", value: yearString))
            items.append(URLQueryItem(name: "hydrate", value: "team(division)"))
            
            return items
        }
     }
}
