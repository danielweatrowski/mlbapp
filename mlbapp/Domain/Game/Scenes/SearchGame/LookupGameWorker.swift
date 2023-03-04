//
//  SearchGameWorker.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation
import Combine

class LookupGameWorker {
    
    func lookupGames(for request: LookupGame.Request) async throws -> [LookupGame.Result] {
        let team = ActiveTeam(rawValue: request.parameters.homeTeamIndex)!
        let opponent = ActiveTeam(rawValue: request.parameters.awayTeamIndex)!
        let gameType = request.parameters.onlyRegularSeason ? "R" : nil

        
        let searchParameters = SwiftMLBRequest.ScheduleParameters(startDate: request.parameters.startDate,
                                                                  endDate: request.parameters.endDate,
                                                                  teamIdentifier: String(team.id),
                                                                  opponentIdentifier: opponent == .any ? nil : String(opponent.id),
                                                                  gameType: gameType)
        
        
        let schedule = try await SwiftMLB.schedule(parameters: searchParameters)
        
        let games = schedule.games.map { game in
            LookupGame.Result(dto: game)
        }
        
        return games
    }
    
}
