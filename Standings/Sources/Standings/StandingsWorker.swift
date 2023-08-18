//
//  StandingsWorker.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation
import Models

public protocol StandingsStoreProtocol {
    func fetchStandings(for date: Date) async throws -> Standings
}

class StandingsWorker<Store: StandingsStoreProtocol>: StandingsStoreProtocol {
    
    let store: Store
    private(set) var standings: Standings?
    
    init(store: Store) {
        self.store = store
    }
    
    func fetchStandings(for date: Date) async throws -> Standings {
        let standings = try await store.fetchStandings(for: date)
        
        self.standings = standings
        return standings
    }
    
    func fetchTeamRecord(teamId: Int) -> Standings.TeamRecord? {
        guard let standings = standings else {
            return nil
        }
        
        for league in [standings.americanLeagueRecords, standings.nationalLeagueRecords] {

            for teamRecord in league.allRecords {
                if teamRecord.teamID == teamId {
                    return teamRecord
                }
            }
        }
        
        // not found
        return nil
    }
}
