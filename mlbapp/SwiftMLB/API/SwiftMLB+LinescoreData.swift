//
//  SwiftMLB+LineScore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/13/22.
//

import Foundation

extension SwiftMLB {
    static func linescoreData(gameIdentifier: Int) async throws -> [String: Any] {
        let request: SwiftMLBRequest = .linescore(gameIdentifier)
        
        let data = try await networkService.load(request)
        let serializer = SwiftMLBSerialization(data: data, builder: PassThruBuilder())

        let linescore = try serializer.jsonObject()
        return linescore
    }
}
