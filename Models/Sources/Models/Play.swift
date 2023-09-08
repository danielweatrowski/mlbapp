//
//  Play.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation

public struct PlayDetail {
    public init(allPlays: [Play], currentPlay: Play?) {
        self.allPlays = allPlays
        self.currentPlay = currentPlay
    }
    
    public var allPlays: [Play]
    public var currentPlay: Play?
}

public struct Play {
    
    public var result: Result
    public var about: Detail
    public var filterParamters: FilterParameters?
    public var matchup: Matchup
    public var count: Count?
    public var events: [Event]
    
    public var isHomerun: Bool {
        return result.eventType == "home_run"
    }
    
    public var isScoringPlay: Bool {
        return about.isScoringPlay
    }
    
    public var isStrikeOut: Bool {
        return result.eventType == "strikeout"
        || result.eventType == "strike_out"
        || result.eventType == "stikeout_double_play"
        || result.eventType == "stikeout_triple_play"
    }
    
    public var isHomeTeam: Bool {
        return about.halfInning == "bottom"
    }
    
    public var isAwayTeam: Bool {
        return about.halfInning == "top"
    }
    
    public init(result: Play.Result, about: Play.Detail, filterParamters: Play.FilterParameters? = nil, matchup: Play.Matchup, count: Count? = nil, events: [Play.Event]) {
        self.result = result
        self.about = about
        self.filterParamters = filterParamters
        self.matchup = matchup
        self.count = count
        self.events = events
    }
    
    public struct Matchup {
        public init(batter: Person, pitcher: Person) {
            self.batter = batter
            self.pitcher = pitcher
        }
        
        public let batter: Person
        public let pitcher: Person
    }
    
    public struct Result {
        public init(type: String, event: String? = nil, eventType: String? = nil, description: String? = nil, rbi: Int, awayScore: Int, homeScore: Int, isOut: Bool) {
            self.type = type
            self.event = event
            self.eventType = eventType
            self.description = description
            self.rbi = rbi
            self.awayScore = awayScore
            self.homeScore = homeScore
            self.isOut = isOut
        }
        
        public var type: String
        public var event: String?
        public var eventType: String?
        public var description: String?
        public var rbi: Int
        public var awayScore: Int
        public var homeScore: Int
        public var isOut: Bool
    }
    
    public struct Detail {
        public init(atBatIndex: Int, halfInning: String, inning: Int, hasOut: Bool, endTime: Date?, isScoringPlay: Bool) {
            self.atBatIndex = atBatIndex
            self.halfInning = halfInning
            self.inning = inning
            self.hasOut = hasOut
            self.endTime = endTime
            self.isScoringPlay = isScoringPlay
        }
        
        public var atBatIndex: Int
        public var halfInning: String
        public var inning: Int
        public var hasOut: Bool
        public var endTime: Date?
        public var isScoringPlay: Bool
    }
    
    public struct RunnerAction {
        public init(runnerID: Int, originBase: String? = nil, startBase: String? = nil, endBase: String? = nil, isOut: Bool, outNumber: Int? = nil) {
            self.runnerID = runnerID
            self.originBase = originBase
            self.startBase = startBase
            self.endBase = endBase
            self.isOut = isOut
            self.outNumber = outNumber
        }
        
        public let runnerID: Int
        
        public let originBase: String?
        public let startBase: String?
        public let endBase: String?
        
        public let isOut: Bool
        public let outNumber: Int?
    }
    
    public struct EventType {
        
        public init(plateAppearance: Bool, hit: Bool, code: String, baseRunningEvent: Bool, description: String) {
            self.plateAppearance = plateAppearance
            self.hit = hit
            self.code = code
            self.baseRunningEvent = baseRunningEvent
            self.description = description
        }
        
        public let plateAppearance: Bool
        public let hit: Bool
        public let code: String
        public let baseRunningEvent: Bool
        public let description: String
    }
    
    public struct FilterParameters {
        
        public init(isHit: Bool, isScoringPlay: Bool) {
            self.isHit = isHit
            self.isScoringPlay = isScoringPlay
        }
        
        public var isHit: Bool
        public var isScoringPlay: Bool
    }
    
    public struct Event {
        public init(count: Count?, pitchInfo: Play.PitchInfo? = nil, hitInfo: Play.HitInfo? = nil, callCode: String, callDescription: String, pitchTypeCode: String, pitchTypeDescription: String, isInPlay: Bool, isStrike: Bool, isBall: Bool) {
            self.count = count
            self.pitchInfo = pitchInfo
            self.hitInfo = hitInfo
            self.callCode = callCode
            self.callDescription = callDescription
            self.pitchTypeCode = pitchTypeCode
            self.pitchTypeDescription = pitchTypeDescription
            self.isInPlay = isInPlay
            self.isStrike = isStrike
            self.isBall = isBall
        }
        
        public let count: Count?
        public let pitchInfo: PitchInfo?
        public let hitInfo: HitInfo?
        public let callCode: String
        public let callDescription: String
        public let pitchTypeCode: String
        public let pitchTypeDescription: String
        public let isInPlay: Bool
        public let isStrike: Bool
        public let isBall: Bool
    }
    
    public struct PitchInfo {
        public init(pitchStartSpeed: Double, pitchEndSpeed: Double) {
            self.pitchStartSpeed = pitchStartSpeed
            self.pitchEndSpeed = pitchEndSpeed
        }
        
        public let pitchStartSpeed: Double
        public let pitchEndSpeed: Double
    }
    
    public struct HitInfo {
        public init(launchSpeed: Double? = nil, launchAngle: Double? = nil, totalDistance: Double? = nil) {
            self.launchSpeed = launchSpeed
            self.launchAngle = launchAngle
            self.totalDistance = totalDistance
        }
        
        public var launchSpeed: Double?
        public var launchAngle: Double?
        public var totalDistance: Double?
    }
}

