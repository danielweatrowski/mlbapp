//
//  SwiftMLB+GameLookup.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import Foundation
import Combine

public extension SwiftMLB {
    
    struct ScheduleParameters {
        var startDate: Date
        var endDate: Date
        var teamIdentifier: Int
        var opponentIdentifier: Int?
        var gameType: String?
    }
    
    static func schedule(parameters: ScheduleParameters) -> AnyPublisher<GameLookupResponse, Error> {
        // format dates
        let startDateFormatted = parameters.startDate.formatted(date: .numeric, time: .omitted)
        let endDateFormatted = parameters.endDate.formatted(date: .numeric, time: .omitted)
        var urlString = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(startDateFormatted)&endDate=\(endDateFormatted)&teamId=\(parameters.teamIdentifier)"
        
        if let opponentIdentifier = parameters.opponentIdentifier {
            urlString.append("&opponentId=\(opponentIdentifier)")
        }
        
        if let gameType = parameters.gameType {
            urlString.append("&gameType=\(gameType)")
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

