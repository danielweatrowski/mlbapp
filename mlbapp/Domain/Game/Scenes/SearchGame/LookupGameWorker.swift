//
//  SearchGameWorker.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation
import Combine

class LookupGameWorker {
    //typealias LookupGameResult = MLBGame
    private var cancellation: AnyCancellable?
    
    // Creates a read only publisher
    var publisher: AnyPublisher<[Game], Error> {
        // Here we're "erasing" the information of which type
        // that our subject actually is, only letting our outside
        // code know that it's a read-only publisher:
        subject.eraseToAnyPublisher()
    }
    
    let subject = PassthroughSubject<[Game],Error>()
    
    func lookupGames(for request: LookupGame.LookupGame.Request) async throws -> [LookupGame.LookupGame.Result] {
        let team = Team(rawValue: request.homeTeamIndex)!
        let opponent = Team(rawValue: request.awayTeamIndex)!
        let gameType = request.onlyRegularSeason ? "R" : nil

        
        let searchParameters = SwiftMLBRequest.ScheduleParameters(startDate: request.startDate,
                                                                  endDate: request.endDate,
                                                                  teamIdentifier: String(team.id),
                                                                  opponentIdentifier: opponent == .any ? nil : String(opponent.id),
                                                                  gameType: gameType)
        
        
        let schedule = try await SwiftMLB.schedule(parameters: searchParameters)
        
        let games = schedule.games.map { game in
            LookupGame.LookupGame.Result(dto: game)
        }
        
        return games
    }
    
}
