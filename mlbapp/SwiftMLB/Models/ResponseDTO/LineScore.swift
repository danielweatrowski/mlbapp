//
//  LineScore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/13/22.
//

import Foundation

// MARK: - LineScoreResponse
public struct LineScoreResponse: Codable {
    let gameData: GameData
    let liveData: LiveData
}

// MARK: - GameData
internal struct GameData: Codable {
    let status: Status
    let teams: GameDataTeams
}

// MARK: - Status
internal struct Status: Codable {
    let abstractGameState: String
}

// MARK: - GameDataTeams
internal struct GameDataTeams: Codable {
    let away, home: PurpleAway
}

// MARK: - PurpleAway
internal struct PurpleAway: Codable {
    let teamName, shortName: String
}

// MARK: - LiveData
internal struct LiveData: Codable {
    let linescore: Linescore
}

// MARK: - Linescore
internal struct Linescore: Codable {
    let innings: [Inning]
    let teams: TeamData
}

// MARK: - Inning
internal struct Inning: Codable {
    let num: Int
    let home, away: InningData
}

// MARK: - InningAway
internal struct InningData: Codable {
    let runs, hits, errors: Int
}

// MARK: - LinescoreTeams
internal struct TeamData: Codable {
    let home, away: InningData
}
