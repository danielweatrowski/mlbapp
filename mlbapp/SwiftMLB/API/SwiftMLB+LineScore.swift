//
//  SwiftMLB+LineScore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/13/22.
//

import Foundation
import Combine

public extension SwiftMLB {
    
    static func lineScore(withGameIdentifer gameIdentifier: Int) -> AnyPublisher<LineScoreResponse, Error> {
        let url = URL(string: "https://statsapi.mlb.com/api/v1.1/game/\(gameIdentifier)/feed/live"
                      + "?fields=gameData,teams,teamName,shortName,status,abstractGameState,liveData,linescore,innings,num,home,away,runs,hits,errors")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: LineScoreResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
 
