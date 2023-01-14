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
        guard let teamData = gameData["teams"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams")
        }
        guard let homeData = teamData["home"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams.home")
        }
        guard let awayData = teamData["away"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams.away")
        }
        guard let playerData = gameData["players"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "players")
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
            "players": playerData,
            "homeBoxData": homeBoxData,
            "awayBoxData": awayBoxData,
            "home": homeData,
            "away": awayData,
            "homeBatters": homeBatters,
            "awayBatters": awayBatters,
            "homeNotes": homeNotes,
            "awayNotes": awayNotes,
            "homeBattingTotals": homeBattingTotals,
            "awayBattingTotals": awayBattingTotals,
            "homePitchers": homePitchers,
            "awayPitchers": awayPitchers,
            "homePitchingTotals": homePitchingTotals,
            "awayPitchingTotals": awayPitchingTotals
        ]
        
        return boxData
    }
    
    private func buildPitcherInfo(from dict: [String: Any]) -> [String: Any] {
        var returnDict = [String: Any]()

        if let personDict = dict["person"] as? [String: Any] {
            returnDict["fullName"] = personDict["fullName"] as? String
            returnDict["personID"] = personDict["id"] as? Int
        }
        
        // game stats
        if let statsDict = dict["stats"] as? [String: Any] {
            if let pitchingStatsDict = statsDict["pitching"] as? [String: Any] {
                returnDict["runs"] = pitchingStatsDict["runs"] as? Int ?? 0
                returnDict["doubles"] = pitchingStatsDict["doubles"] as? Int ?? 0
                returnDict["triples"] = pitchingStatsDict["triples"] as? Int ?? 0
                returnDict["homeRuns"] = pitchingStatsDict["homeRuns"] as? Int ?? 0
                returnDict["strikeOuts"] = pitchingStatsDict["strikeOuts"] as? Int ?? 0
                returnDict["baseOnBalls"] = pitchingStatsDict["baseOnBalls"] as? Int ?? 0
                returnDict["hits"] = pitchingStatsDict["hits"] as? Int ?? 0
                returnDict["atBats"] = pitchingStatsDict["atBats"] as? Int ?? 0
                returnDict["stolenBases"] = pitchingStatsDict["stolenBases"] as? Int ?? 0
                returnDict["rbi"] = pitchingStatsDict["rbi"] as? Int ?? 0
                returnDict["note"] = pitchingStatsDict["note"] as? String ?? ""
                returnDict["earnedRuns"] = pitchingStatsDict["earnedRuns"] as? Int ?? 0
                returnDict["inningsPitched"] = pitchingStatsDict["inningsPitched"] as? String ?? ""
                returnDict["numberOfPitches"] = pitchingStatsDict["numberOfPitches"] as? Int ?? 0
                returnDict["wins"] = pitchingStatsDict["wins"] as? Int ?? 0
                returnDict["holds"] = pitchingStatsDict["holds"] as? Int ?? 0
                returnDict["blownSaves"] = pitchingStatsDict["blownSaves"] as? Int ?? 0
                returnDict["strikes"] = pitchingStatsDict["strikes"] as? Int ?? 0
                returnDict["losses"] = pitchingStatsDict["losses"] as? Int ?? 0
            } else {
                returnDict["runs"] = 0
                returnDict["doubles"] = 0
                returnDict["triples"] = 0
                returnDict["homeRuns"] = 0
                returnDict["strikeOuts"] = 0
                returnDict["baseOnBalls"] = 0
                returnDict["hits"] = 0
                returnDict["atBats"] = 0
                returnDict["stolenBases"] = 0
                returnDict["rbi"] = 0
                returnDict["note"] = ""
                returnDict["earnedRuns"] = 0
                returnDict["inningsPitched"] = "0"
                returnDict["numberOfPitches"] = 0
                returnDict["wins"] = 0
                returnDict["holds"] = 0
                returnDict["blownSaves"] = 0
                returnDict["strikes"] = 0
                returnDict["losses"] = 0
            }
        }
        
        // season stats
        if let seasonStatsDict = dict["seasonStats"] as? [String: Any] {
            if let pitchingStatsDict = seasonStatsDict["batting"] as? [String: Any] {
                returnDict["era"] = pitchingStatsDict["era"] as? String ?? "0"

            } else {
                returnDict["era"] = "0"
            }
        }
            
        return returnDict

    }
    
    private func buildBatterInfo(from dict: [String: Any]) -> [String: Any] {
        var returnDict = [String: Any]()
        
        returnDict["battingOrder"] = dict["battingOrder"] as? String
        
        if let personDict = dict["person"] as? [String: Any] {
            returnDict["fullName"] = personDict["fullName"] as? String
            returnDict["personID"] = personDict["id"] as? Int
        }
        
        if let positionDict = dict["position"] as? [String: String] {
            returnDict["position"] = positionDict["abbreviation"]
        }
        
        // game stats
        if let statsDict = dict["stats"] as? [String: Any] {
            if let battingStatsDict = statsDict["batting"] as? [String: Any] {
                returnDict["runs"] = battingStatsDict["runs"] as? Int ?? 0
                returnDict["doubles"] = battingStatsDict["doubles"] as? Int ?? 0
                returnDict["triples"] = battingStatsDict["triples"] as? Int ?? 0
                returnDict["homeRuns"] = battingStatsDict["homeRuns"] as? Int ?? 0
                returnDict["strikeOuts"] = battingStatsDict["strikeOuts"] as? Int ?? 0
                returnDict["baseOnBalls"] = battingStatsDict["baseOnBalls"] as? Int ?? 0
                returnDict["hits"] = battingStatsDict["hits"] as? Int ?? 0
                returnDict["atBats"] = battingStatsDict["atBats"] as? Int ?? 0
                returnDict["stolenBases"] = battingStatsDict["stolenBases"] as? Int ?? 0
                returnDict["rbi"] = battingStatsDict["rbi"] as? Int ?? 0
                returnDict["leftOnBase"] = battingStatsDict["leftOnBase"] as? Int ?? 0
                returnDict["note"] = battingStatsDict["note"] as? String ?? ""
            } else {
                returnDict["runs"] = 0
                returnDict["doubles"] = 0
                returnDict["triples"] = 0
                returnDict["homeRuns"] = 0
                returnDict["strikeOuts"] = 0
                returnDict["baseOnBalls"] = 0
                returnDict["hits"] = 0
                returnDict["atBats"] = 0
                returnDict["stolenBases"] = 0
                returnDict["rbi"] = 0
                returnDict["leftOnBase"] = 0
            }
        }
        
        // season stats
        if let seasonStatsDict = dict["seasonStats"] as? [String: Any] {
            if let battingStatsDict = seasonStatsDict["batting"] as? [String: Any] {
                returnDict["avg"] = battingStatsDict["avg"] as! String
                returnDict["slg"] = battingStatsDict["slg"] as! String
                returnDict["ops"] = battingStatsDict["ops"] as! String
                returnDict["obp"] = battingStatsDict["obp"] as! String
            } else {
                returnDict["avg"] = "0"
                returnDict["slg"] = "0"
                returnDict["ops"] = "0"
                returnDict["obp"] = "0"
            }
        }
        
        return returnDict
    }
    
}
