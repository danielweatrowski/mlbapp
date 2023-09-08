//
//  MLBPlay.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/14/23.
//

import Foundation

public struct MLBPlays: Decodable {
    public let allPlays: [MLBPlay]
    public let currentPlay: MLBPlay?
}

public struct MLBPlay: Decodable {
    
    public let result: Result
    public let about: About
    public let count: Count?
    public let matchup: Matchup?
    public let playEvents: [Event]?
    
    
    public struct Result: Decodable {
        public let type: String
        public let event: String?
        public let eventType: String?
        public let description: String?
        public let rbi: Int?
        public let awayScore: Int
        public let homeScore: Int
        public let isOut: Bool?
    }
    
    public struct About: Decodable {
        public let atBatIndex: Int
        public let halfInning: String
        public let inning: Int
        public let startTime: String
        public let endTime: String
        public let hasOut: Bool?
        public let isScoringPlay: Bool?
    }
    
    public struct Count: Decodable {
        public let balls: Int
        public let strikes: Int
        public let outs: Int
    }
    
    public struct EventType: Decodable {
        public let plateAppearance: Bool
        public let hit: Bool
        public let code: String
        public let baseRunningEvent: Bool
        public let description: String
    }
    
    public struct Matchup: Decodable {
        public let batter: MLBPerson
        public let pitcher: MLBPerson
        public let batSide: MLBPlayer.Orientation
        public let pitchHand: MLBPlayer.Orientation
    }
    
    public struct Event: Decodable {
        public let details: EventDetail?
        public let count: Count?
        public let pitchData: PitchData?
        public let hitData: HitData?
        
        public let index: Int
        public let pitchNumber: Int?
        public let isPitch: Bool?
        public let type: String?
    }
    
    public struct EventDetail: Decodable {
        
        public let description: String?
        public let code: String?
        public let isInPlay: Bool?
        public let isBall: Bool?
        public let isStrike: Bool?
        public let isOut: Bool?
        public let type: PitchType?
        public let call: PitchType?
    }
    
    public struct PitchType: Decodable {
        public let code: String?
        public let description: String?
    }
    
    public struct PitchData: Decodable {
        public let startSpeed: Double?
        public let endSpeed: Double?
    }
    
    public struct HitData: Decodable {
        public let launchAngle: Double?
        public let launchSpeed: Double?
        public let totalDistance: Double?
        public let trajectory: String?
        public let hardness: String?
    }
}
