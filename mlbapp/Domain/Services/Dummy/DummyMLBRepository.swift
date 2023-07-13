//
//  DummyMLBRepository.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/10/23.
//

import Foundation

struct DummyMLBRepository: GameStoreProtocol {
    func fetchPlayEventTypes() async throws -> [String: Play.EventType] {
        fatalError()
    }
    
    func fetchRoster(teamID id: Int, date: Date) async throws -> Roster {
        fatalError()
    }
    
    
    let games: [Int: Game]
    let gameSearchResults: [GameSearch.Result]
    
    init() {
        // TODO: Load data
        let gameLive1 = Bundle.main.decode(Game.self, from: "game-live-717841.json")
        let gameLive2 = Bundle.main.decode(Game.self, from: "game-live-717837.json")
        
        let gameResult1 = Bundle.main.decode(GameSearch.Result.self, from: "game-search-live-717841.json")
        let gameResult2 = Bundle.main.decode(GameSearch.Result.self, from: "game-search-live-717837.json")
        
        self.games = [
            gameLive1.id: gameLive1,
            gameLive2.id: gameLive2
        ]
        
        self.gameSearchResults = [gameResult1, gameResult2]
    }
    
    func fetchGame(withID id: Int) async throws -> Game {
        guard let game = games[id] else {
            fatalError()
        }
        
        return game
    }
    
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result] {
        guard !gameSearchResults.isEmpty else {
            fatalError()
        }
        
        return gameSearchResults
    }
    
    func fetchBoxscore(forGameID id: Int) async throws -> Boxscore {
        fatalError()
    }
    
    func fetchAllPlays(forGameID id: Int) async throws -> [Play]  {
        fatalError()
    }
    
    func fetchHighlightVideos(forGameID id: Int) async throws -> [HighlightVideo] {
        fatalError()
    }
    
}
