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

        for infoDict in awayInfo {
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
                let batterDict = buildPlayerInfo(from: playerDict)//buildBatterInfo(from: playerDict)
                homeBatters.append(batterDict)
            }
        }
        
        // away batters
        var awayBatters = [[String: Any]]()
        for playerID in awayBatterIDs {
            let playerKey = "ID\(playerID)"
            
            if let playerDict = awayPlayerInfo[playerKey] as? [String: Any] {
                let batterDict = buildPlayerInfo(from: playerDict)
                awayBatters.append(batterDict)
            }
        }
        
        // home pitchers
        var homePitchers = [[String: Any]]()
        for playerID in homePitcherIDs {
            let playerKey = "ID\(playerID)"
            
            if let playerDict = homePlayerInfo[playerKey] as? [String: Any] {
                let pitcherDict = buildPlayerInfo(from: playerDict)
                homePitchers.append(pitcherDict)
            }
        }
        
        // away pitchers
        var awayPitchers = [[String: Any]]()
        for playerID in awayPitcherIDs {
            let playerKey = "ID\(playerID)"
            
            if let playerDict = awayPlayerInfo[playerKey] as? [String: Any] {
                let pitcherDict = buildPlayerInfo(from: playerDict)
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

        let homeJSON: [String: Any] = [
            "batters": homeBatters,
            "pitchers": homePitchers,
            "stats": homeTeamStatsData,
            "notes": homeNotes,
            "battingInfo": homeBattingInfoList,
            "fieldingInfo": homeFieldingInfoList
        ]
        
        let awayJSON: [String: Any] = [
            "batters": awayBatters,
            "pitchers": awayPitchers,
            "stats": awayTeamStatsData,
            "notes": awayNotes,
            "battingInfo": awayBattingInfoList,
            "fieldingInfo": awayFieldingInfoList
        ]
        
        let boxData: [String: Any] = [
            "gameId": gameInfo["id"] as! String,
            "home": homeJSON,
            "away": awayJSON
        ]
        
        return boxData
    }
    
    private func buildPlayerInfo(from dict: [String: Any]) -> [String: Any] {
        // var batterStatsDict = [String: Any]()
        var returnDict = [String: Any]()
        
        returnDict["battingOrder"] = dict["battingOrder"] as? String
        returnDict["jerseyNumber"] = dict["jerseyNumber"] as? String
        returnDict["position"] = dict["position"] as? [String: String]
        
        if let personDict = dict["person"] as? [String: Any] {
            returnDict["fullName"] = personDict["fullName"] as? String
            returnDict["id"] = personDict["id"] as? Int
        }
        
        returnDict["seasonStats"] = dict["seasonStats"] as? [String: Any]
        returnDict["stats"] = dict["stats"] as? [String: Any]
        
        return returnDict
    }
    
}
