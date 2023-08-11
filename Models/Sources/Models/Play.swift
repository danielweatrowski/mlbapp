//
//  Play.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation

public struct Play {
    
    public var result: Result
    public var about: Detail
    public var filterParamters: FilterParameters?
    
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
    
    public init(result: Play.Result, about: Play.Detail, filterParamters: Play.FilterParameters? = nil) {
        self.result = result
        self.about = about
        self.filterParamters = filterParamters
    }
    
    public struct Result {
        
        public init(type: String, event: String, eventType: String, description: String, rbi: Int, awayScore: Int, homeScore: Int, isOut: Bool) {
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
        public var event: String
        public var eventType: String
        public var description: String
        public var rbi: Int
        public var awayScore: Int
        public var homeScore: Int
        public var isOut: Bool
    }
    
    public struct Detail {
        public init(atBatIndex: Int, halfInning: String, inning: Int, hasOut: Bool, endTime: Date, isScoringPlay: Bool) {
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
        public var endTime: Date
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
}

