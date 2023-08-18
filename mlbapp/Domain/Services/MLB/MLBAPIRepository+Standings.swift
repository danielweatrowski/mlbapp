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
                                                    season: teamRecordDTO.season,
                                                    rank: Int(teamRecordDTO.divisionRank)!,
                                                    wildCardRank: Int(teamRecordDTO.wildCardRank ?? "0")!,
                                                    wildCardGamesBack: Stat<String>(value: teamRecordDTO.wildCardGamesBack),
                                                    division: division,
                                                    league: league,
                                                    wins: Stat<Int>(value: teamRecordDTO.wins),
                                                    losses: Stat<Int>(value: teamRecordDTO.losses),
                                                    gamesBehind: Stat<String>(value: teamRecordDTO.gamesBack),
                                                    winPercentage: teamRecordDTO.winningPercentage.asStat(),
                                                    last10Record: Stat<String>(value: lastTenRecord),
                                                    streak: Stat<String>(value: teamRecordDTO.streak?.streakCode),
                                                    runsAllowed: teamRecordDTO.runsAllowed.asStat(),
                                                    runsScored: teamRecordDTO.runsScored.asStat(),
                                                    runDifferential: teamRecordDTO.runDifferential.asStat(),
                                                    gamesPlayed: teamRecordDTO.gamesPlayed.asStat(),
                                                    homeRecord: getRecordSplit(forType: .home, splitsDTO: teamRecordDTO.records.splitRecords),
                                                    awayRecord: getRecordSplit(forType: .away, splitsDTO: teamRecordDTO.records.splitRecords), extraInningRecord: getRecordSplit(forType: .extraInning, splitsDTO: teamRecordDTO.records.splitRecords), last10: getRecordSplit(forType: .lastTen, splitsDTO: teamRecordDTO.records.splitRecords),
                                                    xWinLossRecord: getRecordSplit(forType: .xWinLoss, splitsDTO: teamRecordDTO.records.expectedRecords),
                                                    xSeasonWinLossRecord: getRecordSplit(forType: .xWinLossSeason, splitsDTO: teamRecordDTO.records.expectedRecords),
                                                    americanLeagueRecord: getRecordSplit(forLeague: .american, leagueRecordsDTO: teamRecordDTO.records.leagueRecords),
                                                    nationalLeagueRecord: getRecordSplit(forLeague: .national, leagueRecordsDTO: teamRecordDTO.records.leagueRecords))
                                
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
    
    func getRecordSplit(forType type: RecordSplitType, splitsDTO: [MLBStandings.SplitRecord]?) -> WinLossRecord? {
        guard let splitsDTO = splitsDTO else {
            return nil
        }
        
        let record = splitsDTO.first(where: {$0.type == type.rawValue})
        
        guard let record = record else {
            return nil
        }
        
        return WinLossRecord(wins: record.wins, losses: record.losses, winningPct: record.pct)
    }
    
    func getRecordSplit(forLeague league: ActiveLeague, leagueRecordsDTO: [MLBStandings.LeagueRecord]?) -> WinLossRecord? {
        guard let records = leagueRecordsDTO else {
            return nil
        }
        
        switch league {
        case .national:
            if let split = leagueRecordsDTO?.first(where: {$0.league.name == ActiveLeague.national.name}) {
                return WinLossRecord(wins: split.wins, losses: split.losses, winningPct: split.pct)
            }
        case .american:
            if let split = leagueRecordsDTO?.first(where: {$0.league.name == ActiveLeague.american.name}) {
                return WinLossRecord(wins: split.wins, losses: split.losses, winningPct: split.pct)
            }
        }
        
        return nil
    }
}
