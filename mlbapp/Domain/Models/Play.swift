//
//  Play.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation

struct Play {
    
    var result: Result
    var about: Detail
    var filterParamters: FilterParameters?
    
    var isHomerun: Bool {
        return result.eventType == "home_run"
    }
    
    var isScoringPlay: Bool {
        return about.isScoringPlay
    }
    
    var isStrikeOut: Bool {
        return result.eventType == "strikeout"
        || result.eventType == "strike_out"
        || result.eventType == "stikeout_double_play"
        || result.eventType == "stikeout_triple_play"
    }
    
    var isHomeTeam: Bool {
        return about.halfInning == "bottom"
    }
    
    var isAwayTeam: Bool {
        return about.halfInning == "top"
    }
    
//    var count: Count
//    
//    var runners: [RunnerAction]
//    
//    let batterID: Int
//    let pitcherID: Int
    
    struct Result {
        var type: String
        var event: String
        var eventType: String
        var description: String
        var rbi: Int
        var awayScore: Int
        var homeScore: Int
        var isOut: Bool
    }
    
    struct Detail {
        var atBatIndex: Int
        var halfInning: String
        var inning: Int
        var hasOut: Bool
        var endTime: Date
        var isScoringPlay: Bool
    }
    
    struct RunnerAction {
        let runnerID: Int
        
        let originBase: String?
        let startBase: String?
        let endBase: String?
        
        let isOut: Bool
        let outNumber: Int?
    }
    
    struct EventType {
        let plateAppearance: Bool
        let hit: Bool
        let code: String
        let baseRunningEvent: Bool
        let description: String
    }
    
    struct FilterParameters {
        var isHit: Bool
        var isScoringPlay: Bool
    }
}

