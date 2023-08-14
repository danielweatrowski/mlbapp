//
//  MLBAPIRepository+Standings.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation
import SwiftMLB
import Standings
import Models

extension MLBAPIRepository: StandingsStoreProtocol {
    func fetchStandings(for date: Date) async throws -> Standings {
        let standingsParameters = SwiftMLBRequest.StandingsParameters(date: date)
        let standings = try await SwiftMLB.standings(paramters: standingsParameters)
        
        var nlEastRecords = [Standings.TeamRecord]()
        var nlCentralRecords = [Standings.TeamRecord]()
        var nlWestRecords = [Standings.TeamRecord]()
        
        var alEastRecords = [Standings.TeamRecord]()
        var alCentralRecords = [Standings.TeamRecord]()
        var alWestRecords = [Standings.TeamRecord]()
        
        // iterate through each division
        for recordDTO in standings.records {
            
            for teamRecordDTO in recordDTO.teamRecords {
                
                guard let division = ActiveDivision(rawValue: teamRecordDTO.team.division.id), let league = ActiveLeague(rawValue: teamRecordDTO.team.league.id) else {
                    // TODO: Handle error here
                    fatalError()
                }
                
                var lastTenRecord: String?
                if let splitRecords = teamRecordDTO.records.splitRecords, let lastTen = splitRecords.first(where: {$0.type == "lastTen"}) {
                    lastTenRecord = "\(lastTen.wins)-\(lastTen.losses)"
                }
                let standing = Standings.TeamRecord(teamID: teamRecordDTO.team.id,
                                                    teamAbbreviation: teamRecordDTO.team.abbreviation,
                                                    teamName: teamRecordDTO.team.name,
                                                    rank: Int(teamRecordDTO.divisionRank)!,
                                                    wildCardRank: Int(teamRecordDTO.wildCardRank ?? "0")!,
                                                    wildCardGamesBack: Stat<String>(value: teamRecordDTO.wildCardGamesBack),
                                                    division: division,
                                                    league: league,
                                                    wins: Stat<Int>(value: teamRecordDTO.wins),
                                                    losses: Stat<Int>(value: teamRecordDTO.losses),
                                                    gamesBehind: Stat<String>(value: teamRecordDTO.gamesBack),
                                                    winPercentage: Stat<String>(value: teamRecordDTO.winningPercentage),
                                                    last10Record: Stat<String>(value: lastTenRecord),
                                                    streak: Stat<String>(value: teamRecordDTO.streak?.streakCode))
                                
                // append to respective division arr
                switch division {
                case .alEast: alEastRecords.append(standing)
                case .alCentral: alCentralRecords.append(standing)
                case .alWest: alWestRecords.append(standing)
                case .nlEast: nlEastRecords.append(standing)
                case .nlCentral: nlCentralRecords.append(standing)
                case .nlWest: nlWestRecords.append(standing)
                }
            }
        }
        
        let nationalLeague = Standings.LeagueRecord.createNationalLeague(eastTeamRecords: nlEastRecords,
                                                                         centralTeamRecords: nlCentralRecords,
                                                                         westTeamRecords: nlWestRecords)
        
        let americanLeague = Standings.LeagueRecord.createAmericanLeague(eastTeamRecords: alEastRecords,
                                                                         centralTeamRecords: alCentralRecords,
                                                                         westTeamRecords: alWestRecords)
        return Standings(nationalLeagueRecords: nationalLeague,
                         americanLeagueRecords: americanLeague)
    }
}
