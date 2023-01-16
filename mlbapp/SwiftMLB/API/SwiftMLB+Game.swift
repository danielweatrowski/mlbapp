//
//  SwiftMLB+GameData.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

extension SwiftMLB {
    
    static func game(gameIdentifier: Int) async throws -> Game {
        let request: SwiftMLBRequest = .game(gameIdentifier)
        let data = try await networkService.load(request)
        
        let serializer = SwiftMLBSerialization(data: data, builder: GameBuilder())
        let gameData = try serializer.data()
        
        let decoder = JSONDecoder()
        let game = try decoder.decode(Game.self, from: gameData)
        
        return game
    }
}
