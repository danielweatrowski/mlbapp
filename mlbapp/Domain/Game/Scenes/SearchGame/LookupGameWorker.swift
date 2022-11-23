//
//  SearchGameWorker.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation
import Combine

class LookupGameWorker {
    typealias LookupGameResult = LookupGame.LookupGameResult
    private var cancellation: AnyCancellable?
    
    // Creates a read only publisher
    var publisher: AnyPublisher<[LookupGameResult], Error> {
        // Here we're "erasing" the information of which type
        // that our subject actually is, only letting our outside
        // code know that it's a read-only publisher:
        subject.eraseToAnyPublisher()
    }
    
    let subject = PassthroughSubject<[LookupGameResult],Error>()
    
    func lookupGames(for request: LookupGame.LookupGame.Request) {
        let team = MLBTeam(rawValue: request.homeTeamIndex)!
        let opponent = MLBTeam(rawValue: request.awayTeamIndex)!
        let gameType = request.onlyRegularSeason ? "R" : nil

        
        let searchParameters = SwiftMLB.ScheduleParameters(startDate: request.startDate,
                                                           endDate: request.endDate,
                                                           teamIdentifier: team.id,
                                                           opponentIdentifier: opponent == .any ? nil : opponent.id,
                                                           gameType: gameType)

        cancellation = SwiftMLB.schedule(parameters: searchParameters)
            .sink(
                receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    
                    let games = response.toLookupGameResultDomain()
                    self.subject.send(games)
            })
    }
    
}
