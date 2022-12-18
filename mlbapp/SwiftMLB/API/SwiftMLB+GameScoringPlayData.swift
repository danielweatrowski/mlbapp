//
//  SwiftMLB+ScoringPlays.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/9/22.
//

import Foundation

extension SwiftMLB {
    
    static func gameScoringPlayData(for gameID: Int) async throws -> [String: Any] {
        let request: SwiftMLBRequest = .scoringPlays(gameID)
        let data = try await networkService.load(request)
        
        // parse the data
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        
        guard let gameData = dict["gameData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "gameData")
        }
        
        guard let teams = gameData["teams"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams")
        }
        
        guard let homeTeamDict = teams["home"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "home")
        }
        
        guard let awayTeamDict = teams["away"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "away")
        }
        
        guard let liveData = dict["liveData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        
        guard let plays = liveData["plays"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "plays")
        }
        
        guard let scoringPlaysArr = plays["scoringPlays"] as? [Int] else {
            throw SwiftMLBError.keyNotFound(key: "scoringPlays")
        }
        
        guard let allPlays = plays["allPlays"] as? [[String: Any]] else {
            throw SwiftMLBError.keyNotFound(key: "allPlays")
        }

        var scoringPlayIndex = 0
        var scoringPlaysDict = [[String: Any]]()
        
        // Get all the scoring play dictionary objects
        // Iterate through all plays and extract plays where `atBatIndex` is found in the `scoringPlaysArr`
        for playDict in allPlays where scoringPlayIndex < scoringPlaysArr.count {
            if let batIndex = playDict["atBatIndex"] as? Int, batIndex == scoringPlaysArr[scoringPlayIndex] {
                scoringPlaysDict.append(playDict)
                scoringPlayIndex += 1
            }
        }
        
        let sortedScoringPlaysDict = try sorted(plays: scoringPlaysDict)
        for pd in sortedScoringPlaysDict {
            pd.printPretty()
        }
        
        return [
            "plays": scoringPlaysDict,
            "home": homeTeamDict,
            "away": awayTeamDict
        ]
    }
    
    private static func sorted(plays: [[String: Any]]) throws -> [[String: Any]] {
        return try plays.sorted { (lhs, rhs) -> Bool in
            guard let lhsAboutDict = lhs["about"] as? [String: Any] else {
                throw SwiftMLBError.keyNotFound(key: "lhs.about")
            }
            
            guard let lhsEndTime = lhsAboutDict["endTime"] as? String else {
                throw SwiftMLBError.keyNotFound(key: "lhs.endtime")
            }
            
            guard let rhsAboutDict = rhs["about"] as? [String: Any] else {
                throw SwiftMLBError.keyNotFound(key: "rhs.about")
            }
            
            guard let rhsEndTime = rhsAboutDict["endTime"] as? String else {
                throw SwiftMLBError.keyNotFound(key: "rhs.endtime")
            }
            
            return lhsEndTime < rhsEndTime
        }
    }
}


