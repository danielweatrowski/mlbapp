//
//  GameRepository.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 2/27/23.
//

import Foundation

protocol GameStoreProtocol {
    func fetchGame(withID id: Int) async throws -> Game
}

struct GameWorker<Store: GameStoreProtocol>: GameStoreProtocol {
    
    var store: Store
    
    func fetchGame(withID id: Int) async throws -> Game {
        return try await store.fetchGame(withID: id)
    }
}
