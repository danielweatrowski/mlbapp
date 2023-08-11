//
//  SearchGameParameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/4/23.
//

import Foundation

public enum GameSearch {
    public struct SearchParameters: Codable {
        
        public init(homeTeamID: Int? = nil, awayTeamID: Int? = nil, startDate: Date, endDate: Date) {
            self.homeTeamID = homeTeamID
            self.awayTeamID = awayTeamID
            self.startDate = startDate
            self.endDate = endDate
        }
        
        public let homeTeamID: Int?
        public let awayTeamID: Int?
        public let startDate: Date
        public let endDate: Date
    }
    
    public struct Result: Hashable, Codable {
        
        public static func == (lhs: GameSearch.Result, rhs: GameSearch.Result) -> Bool {
            return lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            return hasher.combine(id)
        }
        
        public let id: Int
        public let gameDate: Date
        public let venueName: String
        public let status: GameStatus
        public let awayTeam: Team
        public let homeTeam: Team
        public let linescore: Linescore?
        public let decisions: Decisions?
        public let liveInfo: GameLiveInfo?
        
        public init(id: Int, gameDate: Date, venueName: String, status: GameStatus, awayTeam: GameSearch.Result.Team, homeTeam: GameSearch.Result.Team, linescore: Linescore? = nil, decisions: Decisions? = nil, liveInfo: GameLiveInfo? = nil) {
            self.id = id
            self.gameDate = gameDate
            self.venueName = venueName
            self.status = status
            self.awayTeam = awayTeam
            self.homeTeam = homeTeam
            self.linescore = linescore
            self.decisions = decisions
            self.liveInfo = liveInfo
        }
        
        public struct Team: Codable {
            public init(id: Int, name: String, teamName: String, abbreviation: String, score: Int, wins: Int, losses: Int) {
                self.id = id
                self.name = name
                self.teamName = teamName
                self.abbreviation = abbreviation
                self.score = score
                self.wins = wins
                self.losses = losses
            }
            
            public let id: Int
            public let name: String
            public let teamName: String
            public let abbreviation: String
            public let score: Int
            public let wins: Int
            public let losses: Int
            
            public var record: String {
                return "\(wins)-\(losses)"
            }
        }
    }
}
