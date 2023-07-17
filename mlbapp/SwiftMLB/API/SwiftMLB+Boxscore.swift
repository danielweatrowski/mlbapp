//
//  SwiftMLB+Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

extension SwiftMLB {
    static func boxscore(gameIdentifier: Int) async throws -> MLBBoxscore_V2 {
        let request: SwiftMLBRequest = .boxscore(gameIdentifier)

        let data = try await networkService.load(request)
        let decoder = JSONDecoder()
        
        do {
            let boxscore = try decoder.decode(MLBBoxscore_V2.self, from: data)
            return boxscore
        } catch {
            print(error)
            throw error
        }
    }
}
