//
//  MLBAPIRepository+Standings.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation
import SwiftMLB

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
                let standing = Standings.TeamRecord(teamID: teamRecordDTO.team.id,
                                                    teamAbbreviation: teamRecordDTO.team.abbreviation,
                                                    teamName: teamRecordDTO.team.name,
                                                    rank: Int(teamRecordDTO.divisionRank)!,
                                                    wildCardRank: Int(teamRecordDTO.wildCardRank ?? "0")!,
                                                    wildCardGamesBack: teamRecordDTO.wildCardGamesBack,
                                                    division: division,
                                                    league: league,
                                                    wins: teamRecordDTO.wins,
                                                    losses: teamRecordDTO.losses,
                                                    gamesBehind: teamRecordDTO.gamesBack,
                                                    winPercentage: teamRecordDTO.winningPercentage,
                                                    last10Record: "",
                                                    streak: teamRecordDTO.streak?.streakCode ?? "-")
                                
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
