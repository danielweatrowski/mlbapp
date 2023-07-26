//
//  MLBPlay.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/14/23.
//

import Foundation

public struct MLBPlays: Decodable {
    public let allPlays: [MLBPlay]
}

public struct MLBPlay: Decodable {
    
    public let result: Result
    public let about: About
    public let count: Count?
    
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
        public let startTime: Date
        public let endTime: Date
        public let hasOut: Bool
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
}
