//
//  MLBRequestParameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/18/22.
//

import Foundation

public extension SwiftMLBRequest {
    struct ScheduleParameters {
        
        public init(startDate: Date? = nil, endDate: Date? = nil, teamIdentifier: String? = nil, opponentIdentifier: String? = nil, gameType: String? = nil) {
            self.startDate = startDate
            self.endDate = endDate
            self.teamIdentifier = teamIdentifier
            self.opponentIdentifier = opponentIdentifier
            self.gameType = gameType
        }
        
        
        public struct Options {
            public let includeLinescore: Bool
            public let includeDecisions: Bool
            public let includeProbablePitchers: Bool
        }
        
        public var startDate: Date?
        public var endDate: Date?
        public var teamIdentifier: String?
        public var opponentIdentifier: String?
        public var gameType: String?
        public var options: Options = .init(includeLinescore: true,
                                     includeDecisions: true,
                                     includeProbablePitchers: true)
        
        
        func toQueryItems() -> [URLQueryItem] {
            var items = [
                URLQueryItem(name: "startDate", value: startDate?.formatted(date: .numeric, time: .omitted)),
                URLQueryItem(name: "endDate", value: endDate?.formatted(date: .numeric, time: .omitted)),
                URLQueryItem(name: "teamId", value: teamIdentifier),
                URLQueryItem(name: "opponentId", value: opponentIdentifier),
                URLQueryItem(name: "gameType", value: gameType),
                URLQueryItem(name: "sportId", value: "1")
            ]
            
            var hydrations: [String] = []
            if options.includeLinescore {
                hydrations.append("linescore")
            }
            if options.includeProbablePitchers {
                hydrations.append("probablePitchers")
            }
            if options.includeDecisions {
                hydrations.append("decisions")
            }
            
            hydrations.append("team")
            
            if !hydrations.isEmpty {
                let value = hydrations.joined(separator: ",")
                items.append(URLQueryItem(name: "hydrate", value: value))
            }
            
            return items
        }
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
    
    public struct RosterParameters {
        
        public enum RosterType: String  {
            case fortyMan = "40man"
            case active = "active"
            case fullRoster = "fullRoster"
        }
        
        public enum RangeType {
            case date(_ date: Date)
            case season(_ yearString: String)
        }
        
        public init(teamIdentifier: Int, type: RosterType, range: RangeType) {
            self.teamIdentifier = teamIdentifier
            self.type = type
            self.range = range
        }
        
        public let teamIdentifier: Int
        public let type: RosterType
        public let range: RangeType
        
        func toQueryItems() -> [URLQueryItem] {
            var items = [URLQueryItem]()
            
            let hydrateItem = URLQueryItem(name: "hydrate", value: "person")
            items.append(hydrateItem)

            let rosterTypeItem = URLQueryItem(name: "rosterType", value: type.rawValue)
            items.append(rosterTypeItem)
            
            if case .date(let date) = range {
                let rosterRangeItem = URLQueryItem(name: "date", value: date.formatted(date: .numeric, time: .omitted))
                items.append(rosterRangeItem)
            } else if case .season(let year) = range {
                let rosterRangeItem = URLQueryItem(name: "season", value: year)
                items.append(rosterRangeItem)
            }
            
            return items
        }

    }
}
