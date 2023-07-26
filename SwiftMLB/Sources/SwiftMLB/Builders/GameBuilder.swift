//
//  GameBuilder.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/14/23.
//

import Foundation

struct GameBuilder: JSONBuilder {
    private let boxscoreBuilder = BoxscoreBuilder()
    private let teamBuilder = PassThruBuilder()
    
    func build(with data: Data) throws -> [String : Any] {
        
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        
        guard let gameData = dict["gameData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "gameData")
        }
        guard let liveData = dict["liveData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        guard let gameInfo = gameData["game"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "game")
        }
        guard let dateInfo = gameData["datetime"] as? [String: String] else {
            throw SwiftMLBError.keyNotFound(key: "gameData.datetime")
        }
        guard let venueInfo = gameData["venue"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "gameData.venue")
        }
        guard let teamInfo = gameData["teams"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "gameData.teams")
        }
        guard let homeData = teamInfo["home"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams.home")
        }
        guard let awayData = teamInfo["away"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams.away")
        }
        
        guard let playerData = gameData["players"] as? [String: [String: Any]] else {
            throw SwiftMLBError.keyNotFound(key: "gameData.players")
        }
        
        var playersJSON = [[String: Any]]()
        for (_, playerDict) in playerData {
            playersJSON.append(playerDict)
        }

        let decisionJSON = liveData["decisions"] as? [String: Any]
        let probablePitchersJSON = gameData["probablePitchers"] as? [String: Any]
        let statusJSON = gameData["status"] as? [String: Any]
        let weatherJSON = gameData["weather"] as? [String: Any]
        let gameInfoJSON = gameData["gameInfo"] as? [String: Any]
        let linescoreJSON = liveData["linescore"] as? [String: Any]
        let boxscoreJSON = liveData["boxscore"] as? [String: Any]
        let venueJSON = buildVenue(venueDict: venueInfo)
        let awayJSON = try buildTeam(teamDict: awayData)
        let homeJSON = try buildTeam(teamDict: homeData)
        
        return [
            "id": dict["gamePk"],
            "gameID": gameInfo["id"] as? String,
            "type": gameInfo["type"] as? String,
            "season": gameInfo["season"] as? String,
            "gameDate": dateInfo["dateTime"],
            "venue": venueJSON,
            "boxscore": boxscoreJSON,
            "linescore": linescoreJSON,
            "players": playersJSON,
            "decisions": decisionJSON,
            "probablePitchers": probablePitchersJSON,
            "status": statusJSON,
            "weather": weatherJSON,
            "gameInfo": gameInfoJSON,
            "teams": [
                "away": awayJSON,
                "home": homeJSON
            ]
        ]
        
    }
    
    private func buildVenue(venueDict: [String: Any]) -> [String: Any] {
        let venueID = venueDict["id"] as? Int
        let venueName = venueDict["name"] as? String
        let venueLink = venueDict["link"] as? String
        
        return [
            "id": venueID,
            "name": venueName,
            "link": venueLink
        ]
    }
    
    private func buildTeam(teamDict: [String: Any]) throws -> [String: Any] {
        let data = try JSONSerialization.data(withJSONObject: teamDict)
        return try teamBuilder.build(with: data)
        
    }
}
