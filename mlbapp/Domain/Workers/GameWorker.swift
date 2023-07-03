//
//  GameRepository.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 2/27/23.
//

import Foundation

protocol GameStoreProtocol {
    associatedtype P: PlayProtocol
    func fetchGame(withID id: Int) async throws -> Game
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result]
    func fetchAllPlays(forGameID id: Int) async throws -> [P]
    func fetchBoxscore(forGameID id: Int) async throws -> Boxscore
    func fetchRoster(teamID id: Int, date: Date) async throws -> Roster
}

struct GameWorker<Store: GameStoreProtocol> {
    
    var store: Store
    
    func fetchGame(withID id: Int) async throws -> Game {
        return try await store.fetchGame(withID: id)
    }
    
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result] {
        return try await store.searchGame(with: parameters)
    }
    
    func fetchAllPlays(forGameID id: Int) async throws -> [Store.P] {
        return try await store.fetchAllPlays(forGameID: id)
    }
    
    func fetchBoxscore(forGameID id: Int) async throws -> Boxscore {
        return try await store.fetchBoxscore(forGameID: id)
    }
    
    func fetchRoster(teamID id: Int, date: Date) async throws -> Roster {
        return try await store.fetchRoster(teamID: id, date: date)
    }


}
