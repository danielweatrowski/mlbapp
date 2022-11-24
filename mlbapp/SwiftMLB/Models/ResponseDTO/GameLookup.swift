//
//  GameLookup.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation

// MARK: - GameLookupResult
public struct GameLookupResponse: Codable {
    let copyright: String
    let totalItems, totalEvents, totalGames, totalGamesInProgress: Int
    let dates: [GameLookupDateItem]
}

// MARK: - DateElement
public struct GameLookupDateItem: Codable {
    let date: String
    let totalItems, totalEvents, totalGames, totalGamesInProgress: Int
    let games: [GameLookupGame]
}

// MARK: - Game
public struct GameLookupGame: Codable {
    let gamePk: Int
    let link, gameType, season: String
    let gameDate: String
    let officialDate: String
    let status: GameLookupStatus
    let teams: GameLookupTeams
    let venue: GameLookupVenue
    let content: GameLookupContent
    let isTie: Bool
    let gameNumber: Int
    let publicFacing: Bool
    let doubleHeader, gamedayType, tiebreaker, calendarEventID: String
    let seasonDisplay, dayNight: String
    let scheduledInnings: Int
    let reverseHomeAwayStatus: Bool
    let inningBreakLength, gamesInSeries, seriesGameNumber: Int?
    let seriesDescription, recordSource, ifNecessary, ifNecessaryDescription: String
    let rescheduledFrom: String?
    let rescheduledFromDate, gameDescription: String?

    enum CodingKeys: String, CodingKey {
        case gamePk, link, gameType, season, gameDate, officialDate, status, teams, venue, content, isTie, gameNumber, publicFacing, doubleHeader, gamedayType, tiebreaker, calendarEventID, seasonDisplay, dayNight, scheduledInnings, reverseHomeAwayStatus, inningBreakLength, gamesInSeries, seriesGameNumber, seriesDescription, recordSource, ifNecessary, ifNecessaryDescription, rescheduledFrom, rescheduledFromDate
        case gameDescription
    }
}

// MARK: - Content
public struct GameLookupContent: Codable {
    let link: String
}

// MARK: - Status
public struct GameLookupStatus: Codable {
    let abstractGameState, codedGameState, detailedState, statusCode: String
    let startTimeTBD: Bool
    let abstractGameCode: String
}

// MARK: - Teams
public struct GameLookupTeams: Codable {
    let away, home: GameLookupTeamInfo
}

// MARK: - Away
public struct GameLookupTeamInfo: Codable {
    let leagueRecord: GameLookupTeamRecord
    let score: Int
    let team: GameLookupVenue
    let isWinner, splitSquad: Bool
    let seriesNumber: Int
}

// MARK: - LeagueRecord
public struct GameLookupTeamRecord: Codable {
    let wins, losses: Int
    let pct: String
}

// MARK: - Venue
public struct GameLookupVenue: Codable {
    let id: Int
    let name: String
    let link: String
}

