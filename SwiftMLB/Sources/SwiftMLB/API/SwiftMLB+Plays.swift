//
//  SwiftMLB+Plays.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/14/23.
//

import Foundation
import OSLog

public extension SwiftMLB {
    
    static func plays(for gameID: Int) async throws -> MLBPlays {
        let request: SwiftMLBRequest = .plays(gameID)
        
        do {
            let data = try await networkService.load(request)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.iso8601TimeZoneOmitted)
            
            let plays = try decoder.decode(MLBPlays.self, from: data)
            return plays
        } catch {
            Logger.swiftmlb.error("\(error, privacy: .public)")
            throw error
        }
    }
}

extension DateFormatter {
    static let iso8601TimeZoneOmitted: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
}
