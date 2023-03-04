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
}

struct GameWorker<Store: GameStoreProtocol>: GameStoreProtocol {
    
    var store: Store
    
    func fetchGame(withID id: Int) async throws -> Game {
        return try await store.fetchGame(withID: id)
    }
    
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result] {
        return try await store.searchGame(with: parameters)
    }
}
