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

struct StandingsWorker<Store: StandingsStoreProtocol>: StandingsStoreProtocol {
    
    let store: Store
    
    func fetchStandings(for date: Date) async throws -> Standings {
        return try await store.fetchStandings(for: date)
    }
}
