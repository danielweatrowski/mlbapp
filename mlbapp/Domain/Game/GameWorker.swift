//
//  GameRepository.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 2/27/23.
//

import Foundation

protocol GameStoreProtocol {
    func fetchGame(withID id: Int) async throws -> Game
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result]
    func fetchAllPlays(forGameID id: Int) async throws -> [Play]
    func fetchBoxscore(forGameID id: Int) async throws -> Boxscore_V2
    func fetchRoster(teamID id: Int, date: Date) async throws -> Roster
    func fetchPlayEventTypes() async throws -> [String: Play.EventType]
    func fetchHighlightVideos(forGameID id: Int) async throws -> [HighlightVideo]
}

struct GameWorker<Store: GameStoreProtocol> {
    
    var store: Store
    
    func fetchGame(withID id: Int) async throws -> Game {
        return try await store.fetchGame(withID: id)
    }
    
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result] {
        return try await store.searchGame(with: parameters)
    }
    
    func fetchAllPlays(forGameID id: Int) async throws -> [Play] {
        return try await store.fetchAllPlays(forGameID: id)
    }
    
    func fetchBoxscore(forGameID id: Int) async throws -> Boxscore_V2 {
        return try await store.fetchBoxscore(forGameID: id)
    }
    
    func fetchRoster(teamID id: Int, date: Date) async throws -> Roster {
        return try await store.fetchRoster(teamID: id, date: date)
    }

    func fetchPlayEventTypes() async throws -> [String: Play.EventType] {
        return try await store.fetchPlayEventTypes()
    }

    func fetchHighlightVideos(forGameID id: Int) async throws -> [HighlightVideo] {
        return try await store.fetchHighlightVideos(forGameID: id)
    }

}
