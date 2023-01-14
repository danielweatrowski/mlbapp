//
//  SwiftMLB+Linescore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/10/23.
//

import Foundation

extension SwiftMLB {
    static func linescore(gameIdentifier: Int) async throws -> LineScore {
        let request: SwiftMLBRequest = .linescore(gameIdentifier)
        
        let data = try await networkService.load(request)
        
        let serializer = SwiftMLBSerialization(data: data, builder: LinescoreBuilder())
        let linescoreData = try serializer.data()

        let decoder = JSONDecoder()
        let linescore = try decoder.decode(LineScore.self, from: linescoreData)
        return linescore
    }
}
