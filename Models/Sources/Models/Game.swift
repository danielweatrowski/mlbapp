//
//  Game.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

public struct Game {
    
    public let id: Int
    public let date: Date?
    public let homeTeam: Team
    public let homeTeamScore: Int
    public let awayTeam: Team
    public let awayTeamScore: Int
    public let venue: Venue
    public let players: [Int: Player]
    public var info: Info = Info()
    public let status: GameStatus
    public let decisions: Decisions?
    public let probablePitchers: ProbablePitchers?
    public let linescore: Linescore?
    public let boxscore: Boxscore_V2?
    public let liveInfo: GameLiveInfo?
    public let currentPlay: Play?
    
    public lazy var winningPitcher: Player? = {
        guard let winningPitcherID = decisions?.winner.id, let player = players[winningPitcherID] else {
            return nil
        }
        return player
    }()
    
    public lazy var losingPitcher: Player? = {
        guard let losingPitcherID = decisions?.loser.id, let player = players[losingPitcherID] else {
            return nil
        }
        return player
    }()
    
    public init(id: Int, date: Date?, homeTeam: Team, homeTeamScore: Int, awayTeam: Team, awayTeamScore: Int, venue: Venue, players: [Int : Player], info: Game.Info = Info(), status: GameStatus, decisions: Decisions? = nil, probablePitchers: ProbablePitchers? = nil, linescore: Linescore? = nil, boxscore: Boxscore_V2? = nil, liveInfo: GameLiveInfo? = nil, currentPlay: Play? = nil) {
        self.id = id
        self.date = date
        self.homeTeam = homeTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeam = awayTeam
        self.awayTeamScore = awayTeamScore
        self.venue = venue
        self.players = players
        self.info = info
        self.status = status
        self.decisions = decisions
        self.probablePitchers = probablePitchers
        self.linescore = linescore
        self.boxscore = boxscore
        self.liveInfo = liveInfo
        self.currentPlay = currentPlay
    }
    
    public struct Info: Codable {
        
        public var weatherTempurature: String?
        public var windDescription: String?
        public var firstPitchDateString: String?
        public var attendance: Int?
        public var gameDurationInMinutes: Int?
        
        public var firstPitchDate: Date? {
            let dateFormatter = DateFormatter.iso8601TimeZoneOmitted
            return dateFormatter.date(from: firstPitchDateString ?? "")
        }
        
        public init(weatherTempurature: String? = nil, windDescription: String? = nil, firstPitchDateString: String? = nil, attendance: Int? = nil, gameDurationInMinutes: Int? = nil) {
            self.weatherTempurature = weatherTempurature
            self.windDescription = windDescription
            self.firstPitchDateString = firstPitchDateString
            self.attendance = attendance
            self.gameDurationInMinutes = gameDurationInMinutes
        }
    }
}

extension DateFormatter {
    static let iso8601TimeZoneOmitted: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
  }
