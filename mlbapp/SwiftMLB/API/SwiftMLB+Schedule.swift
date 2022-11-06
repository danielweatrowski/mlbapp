//
//  SwiftMLB+GameLookup.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation
import Combine

public extension SwiftMLB {
    
    static func schedule(from startDate: Date, to endDate: Date, teamIdentifier: Int, opponentIdentifier: Int?) -> AnyPublisher<GameLookupResponse, Error> {
        // format dates
        let startDateFormatted = startDate.formatted(date: .numeric, time: .omitted)
        let endDateFormatted = endDate.formatted(date: .numeric, time: .omitted)
        var urlString = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(startDateFormatted)&endDate=\(endDateFormatted)&teamId=\(teamIdentifier)"
        
        if let opponentIdentifier = opponentIdentifier {
            urlString.append("&opponentId=\(opponentIdentifier)")
        }
        
        urlString.append("&sportId=1")
        // https://statsapi.mlb.com/api/v1/schedule?startDate=07/01/2018&endDate=07/31/2018&teamId=143&opponentId=121&sportId=1
        print(urlString)
        let url = URL(string: urlString)!
        //"https://statsapi.mlb.com/api/v1/schedule?startDate=\(startDateFormatted)&endDate=\(endDateFormatted)&teamId=\(teamIdentifier)&opponentId=\(opponentIdentifier)&sportId=1")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: GameLookupResponse.self,
                    decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

