//
//  SwiftMLB+Teams.swift
//  
//
//  Created by Daniel Weatrowski on 10/16/22.
//

import Foundation
import Combine

public extension SwiftMLB {
    
    static func team(withIdentifer teamIdentifier: Int) -> AnyPublisher<[Team], Never> {
        let url = URL(string: "https://statsapi.mlb.com/api/v1/teams/\(teamIdentifier)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TeamResponse.self, decoder: JSONDecoder())
            .map(\.teams)
            .replaceError(with: [Team]())
            .eraseToAnyPublisher() 
    }
}
 
