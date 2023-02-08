//
//  BoxscoreParser.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/8/23.
//

import Foundation

protocol JSONParsable {
    var data: Data { get set }
    func parse() throws -> [String: Any]
}

struct BoxscoreBuilder: JSONBuilder {
    func build(with data: Data) throws -> [String : Any] {
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        guard let gameData = dict["gameData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "gameData")
        }
        guard let gameInfo = gameData["game"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "game")
        }
        guard let liveData = dict["liveData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        guard let boxscoreData = liveData["boxscore"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "boxscore")
        }
        guard let boxscoreTeamsData = boxscoreData["teams"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams")
        }
        guard let homeBoxData = boxscoreTeamsData["home"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.home")
        }
        guard let awayBoxData = boxscoreTeamsData["away"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.away")
        }
        guard let homePlayerInfo = homeBoxData["players"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.home.players")
        }
        guard let awayPlayerInfo = awayBoxData["players"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.away.players")
        }
        guard let homeBatterIDs = homeBoxData["batters"] as? [Int] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.home.batters")
        }
        guard let homePitcherIDs = homeBoxData["pitchers"] as? [Int] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.home.pitchers")
        }
        guard let awayPitcherIDs = awayBoxData["pitchers"] as? [Int] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.away.pitchers")
        }
        guard let awayBatterIDs = awayBoxData["batters"] as? [Int] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.away.batters")
        }
        guard let homeNotesData = homeBoxData["note"] as? [[String: Any]] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.home.note")
        }
        guard let awayNotesData = awayBoxData["note"] as? [[String: Any]] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.away.note")
        }
        guard let homeTeamStatsData = homeBoxData["teamStats"] as? [String : Any] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.home.teamStats")
        }
        guard let awayTeamStatsData = homeBoxData["teamStats"] as? [String : Any] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.away.teamStats")
        }
        guard let homeInfo = homeBoxData["info"] as? [[String : Any]] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.home.info")
        }
        guard let awayInfo = awayBoxData["info"] as? [[String : Any]] else {
            throw SwiftMLBError.keyNotFound(key: "livedata.boxscore.teams.away.info")
        }
        
        // home info
        var homeBattingInfoList = [[String: Any]]()
        var homeFieldingInfoList = [[String: Any]]()

        for infoDict in homeInfo {
            if let title = infoDict["title"] as? String, let fieldList = infoDict["fieldList"] as? [[String: Any]] {
                if title == "BATTING" {
                    homeBattingInfoList = fieldList
                } else if title == "FIELDING" {
                    homeFieldingInfoList = fieldList
                }
            }
        }
        
        // away info
        var awayBattingInfoList = [[String: Any]]()
        var awayFieldingInfoList = [[String: Any]]()

        for infoDict in homeInfo {
            if let title = infoDict["title"] as? String, let fieldList = infoDict["fieldList"] as? [[String: Any]] {
                if title == "BATTING" {
                    awayBattingInfoList = fieldList
                } else if title == "FIELDING" {
                    awayFieldingInfoList = fieldList
                }
            }
        }
        
        // home batters
        var homeBatters = [[String: Any]]()
        for playerID in homeBatterIDs {
            let playerKey = "ID\(playerID)"
            
            if let playerDict = homePlayerInfo[playerKey] as? [String: Any] {
                let batterDict = buildBatterInfo(from: playerDict)
                homeBatters.append(batterDict)
            }
        }
        
        // away batters
        var awayBatters = [[String: Any]]()
        for playerID in awayBatterIDs {
            let playerKey = "ID\(playerID)"
            
            if let playerDict = awayPlayerInfo[playerKey] as? [String: Any] {
                let batterDict = buildBatterInfo(from: playerDict)
                awayBatters.append(batterDict)
            }
        }
        
        // home pitchers
        var homePitchers = [[String: Any]]()
        for playerID in homePitcherIDs {
            let playerKey = "ID\(playerID)"
            
            if let playerDict = homePlayerInfo[playerKey] as? [String: Any] {
                let pitcherDict = buildPitcherInfo(from: playerDict)
                homePitchers.append(pitcherDict)
            }
        }
        
        // away pitchers
        var awayPitchers = [[String: Any]]()
        for playerID in awayPitcherIDs {
            let playerKey = "ID\(playerID)"
            
            if let playerDict = awayPlayerInfo[playerKey] as? [String: Any] {
                let pitcherDict = buildPitcherInfo(from: playerDict)
                awayPitchers.append(pitcherDict)
            }
        }
        
        // home notes
        var homeNotes = [String]()
        for noteDict in homeNotesData {
            if let label = noteDict["label"] as? String, let value = noteDict["value"] as? String {
                let note = "\(label)-\(value)"
                homeNotes.append(note)
            }
        }
        
        // away notes
        var awayNotes = [String]()
        for noteDict in awayNotesData {
            if let label = noteDict["label"] as? String, let value = noteDict["value"] as? String {
                let note = "\(label)-\(value)"
                awayNotes.append(note)
            }
        }
        
        let homeBattingTotals = homeTeamStatsData["batting"] as? [String: Any] ?? [:]
        let awayBattingTotals = awayTeamStatsData["batting"] as? [String: Any] ?? [:]
        let homePitchingTotals = homeTeamStatsData["pitching"] as? [String: Any] ?? [:]
        let awayPitchingTotals = awayTeamStatsData["pitching"] as? [String: Any] ?? [:]
        
        let boxData: [String: Any] = [
            "gameId": gameInfo["id"] as! String,
//            "players": playerData,
//            "homeBoxData": homeBoxData,
//            "awayBoxData": awayBoxData,
//            "home": homeData,
//            "away": awayData,
            "homeBatters": homeBatters,
            "awayBatters": awayBatters,
            "homeNotes": homeNotes,
            "awayNotes": awayNotes,
            "homeBattingTotals": homeBattingTotals,
            "awayBattingTotals": awayBattingTotals,
            "homePitchers": homePitchers,
            "awayPitchers": awayPitchers,
            "homePitchingTotals": homePitchingTotals,
            "awayPitchingTotals": awayPitchingTotals,
            "homeBattingInfo": homeBattingInfoList,
            "awayBattingInfo": awayBattingInfoList,
            "homeFieldingInfo": homeFieldingInfoList,
            "awayFieldingInfo": awayFieldingInfoList
        ]
        
        return boxData
    }
    
    private func buildPitcherInfo(from dict: [String: Any]) -> [String: Any] {
        var pitcherStatsDict = [String: Any]()
        var returnDict = [String: Any]()
        
        if let personDict = dict["person"] as? [String: Any] {
            returnDict["fullName"] = personDict["fullName"] as? String
            returnDict["id"] = personDict["id"] as? Int
        }
        
        // game stats
        if let statsDict = dict["stats"] as? [String: Any] {
            if let pitchingStatsDict = statsDict["pitching"] as? [String: Any] {
                pitcherStatsDict["runs"] = pitchingStatsDict["runs"] as? Int ?? 0
                pitcherStatsDict["doubles"] = pitchingStatsDict["doubles"] as? Int ?? 0
                pitcherStatsDict["triples"] = pitchingStatsDict["triples"] as? Int ?? 0
                pitcherStatsDict["homeRuns"] = pitchingStatsDict["homeRuns"] as? Int ?? 0
                pitcherStatsDict["strikeOuts"] = pitchingStatsDict["strikeOuts"] as? Int ?? 0
                pitcherStatsDict["baseOnBalls"] = pitchingStatsDict["baseOnBalls"] as? Int ?? 0
                pitcherStatsDict["hits"] = pitchingStatsDict["hits"] as? Int ?? 0
                pitcherStatsDict["atBats"] = pitchingStatsDict["atBats"] as? Int ?? 0
                pitcherStatsDict["stolenBases"] = pitchingStatsDict["stolenBases"] as? Int ?? 0
                pitcherStatsDict["rbi"] = pitchingStatsDict["rbi"] as? Int ?? 0
                pitcherStatsDict["note"] = pitchingStatsDict["note"] as? String ?? ""
                pitcherStatsDict["earnedRuns"] = pitchingStatsDict["earnedRuns"] as? Int ?? 0
                pitcherStatsDict["inningsPitched"] = pitchingStatsDict["inningsPitched"] as? String ?? ""
                pitcherStatsDict["numberOfPitches"] = pitchingStatsDict["numberOfPitches"] as? Int ?? 0
                pitcherStatsDict["wins"] = pitchingStatsDict["wins"] as? Int ?? 0
                pitcherStatsDict["holds"] = pitchingStatsDict["holds"] as? Int ?? 0
                pitcherStatsDict["blownSaves"] = pitchingStatsDict["blownSaves"] as? Int ?? 0
                pitcherStatsDict["strikes"] = pitchingStatsDict["strikes"] as? Int ?? 0
                pitcherStatsDict["losses"] = pitchingStatsDict["losses"] as? Int ?? 0
                pitcherStatsDict["saves"] = pitchingStatsDict["saves"] as? Int ?? 0
                pitcherStatsDict["balls"] = pitchingStatsDict["balls"] as? Int ?? 0
                pitcherStatsDict["battersFaced"] = pitchingStatsDict["battersFaced"] as? Int ?? 0
            } else {
                pitcherStatsDict["runs"] = 0
                pitcherStatsDict["doubles"] = 0
                pitcherStatsDict["triples"] = 0
                pitcherStatsDict["homeRuns"] = 0
                pitcherStatsDict["strikeOuts"] = 0
                pitcherStatsDict["baseOnBalls"] = 0
                pitcherStatsDict["hits"] = 0
                pitcherStatsDict["atBats"] = 0
                pitcherStatsDict["stolenBases"] = 0
                pitcherStatsDict["rbi"] = 0
                pitcherStatsDict["note"] = ""
                pitcherStatsDict["earnedRuns"] = 0
                pitcherStatsDict["inningsPitched"] = "0"
                pitcherStatsDict["numberOfPitches"] = 0
                pitcherStatsDict["wins"] = 0
                pitcherStatsDict["holds"] = 0
                pitcherStatsDict["blownSaves"] = 0
                pitcherStatsDict["strikes"] = 0
                pitcherStatsDict["losses"] = 0
                pitcherStatsDict["saves"] = 0
                pitcherStatsDict["balls"] = 0
                pitcherStatsDict["battersFaced"] = 0
            }
        }
        
        // season stats
        if let seasonStatsDict = dict["seasonStats"] as? [String: Any] {
            if let pitchingStatsDict = seasonStatsDict["pitching"] as? [String: Any] {
                pitcherStatsDict["era"] = pitchingStatsDict["era"] as? String ?? "0"

            } else {
                pitcherStatsDict["era"] = "0"
            }
        }
            
        returnDict["stats"] = pitcherStatsDict
        return returnDict

    }
    
    private func buildBatterInfo(from dict: [String: Any]) -> [String: Any] {
        var batterStatsDict = [String: Any]()
        var returnDict = [String: Any]()
        
        returnDict["battingOrder"] = dict["battingOrder"] as? String
        
        if let personDict = dict["person"] as? [String: Any] {
            returnDict["fullName"] = personDict["fullName"] as? String
            returnDict["id"] = personDict["id"] as? Int
        }
        
        if let positionDict = dict["position"] as? [String: String] {
            returnDict["positionAbbreviation"] = positionDict["abbreviation"]
        }
        
        // game stats
        if let statsDict = dict["stats"] as? [String: Any] {
            if let battingStatsDict = statsDict["batting"] as? [String: Any] {
                batterStatsDict["runs"] = battingStatsDict["runs"] as? Int ?? 0
                batterStatsDict["doubles"] = battingStatsDict["doubles"] as? Int ?? 0
                batterStatsDict["triples"] = battingStatsDict["triples"] as? Int ?? 0
                batterStatsDict["homeRuns"] = battingStatsDict["homeRuns"] as? Int ?? 0
                batterStatsDict["strikeOuts"] = battingStatsDict["strikeOuts"] as? Int ?? 0
                batterStatsDict["baseOnBalls"] = battingStatsDict["baseOnBalls"] as? Int ?? 0
                batterStatsDict["hits"] = battingStatsDict["hits"] as? Int ?? 0
                batterStatsDict["atBats"] = battingStatsDict["atBats"] as? Int ?? 0
                batterStatsDict["stolenBases"] = battingStatsDict["stolenBases"] as? Int ?? 0
                batterStatsDict["rbi"] = battingStatsDict["rbi"] as? Int ?? 0
                batterStatsDict["leftOnBase"] = battingStatsDict["leftOnBase"] as? Int ?? 0
                batterStatsDict["note"] = battingStatsDict["note"] as? String ?? ""
            } else {
                batterStatsDict["runs"] = 0
                batterStatsDict["doubles"] = 0
                batterStatsDict["triples"] = 0
                batterStatsDict["homeRuns"] = 0
                batterStatsDict["strikeOuts"] = 0
                batterStatsDict["baseOnBalls"] = 0
                batterStatsDict["hits"] = 0
                batterStatsDict["atBats"] = 0
                batterStatsDict["stolenBases"] = 0
                batterStatsDict["rbi"] = 0
                batterStatsDict["leftOnBase"] = 0
            }
        }
        
        // season stats
        if let seasonStatsDict = dict["seasonStats"] as? [String: Any] {
            if let battingStatsDict = seasonStatsDict["batting"] as? [String: Any] {
                batterStatsDict["avg"] = battingStatsDict["avg"] as! String
                batterStatsDict["slg"] = battingStatsDict["slg"] as! String
                batterStatsDict["ops"] = battingStatsDict["ops"] as! String
                batterStatsDict["obp"] = battingStatsDict["obp"] as! String
            } else {
                batterStatsDict["avg"] = "0"
                batterStatsDict["slg"] = "0"
                batterStatsDict["ops"] = "0"
                batterStatsDict["obp"] = "0"
            }
        }
        
        returnDict["stats"] = batterStatsDict
        return returnDict
    }
    
}
