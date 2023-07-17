//
//  SwiftMLB+Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

extension SwiftMLB {
    // TODO: Test
    static func boxscore(gameIdentifier: Int) async throws -> MLBBoxscore_V2 {
        let request: SwiftMLBRequest = .boxscore(gameIdentifier)

        let data = try await networkService.load(request)
        
        let decoder = JSONDecoder()
        let boxscore = try decoder.decode(MLBBoxscore_V2.self, from: data)
        
        return boxscore
    }
}
