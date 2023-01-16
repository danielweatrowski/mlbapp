//
//  GameBuilder.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/14/23.
//

import Foundation

struct GameBuilder: JSONBuilder {
    private let linescoreBuilder = LinescoreBuilder()
    private let boxscoreBuilder = BoxscoreBuilder()
    private let teamBuilder = TeamBuilder()
    
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

        // TODO: Make linescore json
        let linescoreJSON = try linescoreBuilder.build(with: data)
        let boxscoreJSON = try boxscoreBuilder.build(with: data)
        let venueJSON = buildVenue(venueDict: venueInfo)
        let awayJSON = try buildTeam(teamDict: awayData)
        let homeJSON = try buildTeam(teamDict: homeData)
        
        return [
            "id": dict["gamePk"],
            "gameID": gameInfo["id"] as? String,
            "type": gameInfo["type"] as? String,
            "season": gameInfo["season"] as? String,
            "dateString": dateInfo["dateTime"],
            "venue": venueJSON,
            "boxscore": boxscoreJSON,
            "linescore": linescoreJSON,
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
