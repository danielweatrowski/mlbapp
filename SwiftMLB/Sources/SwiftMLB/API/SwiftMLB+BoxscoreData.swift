//
//  SwiftMLB+BoxscoreData.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/29/22.
//

import Foundation

extension SwiftMLB {
    static func boxscoreData(gameIdentifier: Int) async throws -> [String: Any] {
        let request: SwiftMLBRequest = .boxscore(gameIdentifier)

        let data = try await networkService.load(request)
        
        let serializer = SwiftMLBSerialization(data: data, builder: BoxscoreBuilder())
        let boxscoreData = try serializer.jsonObject()

        return boxscoreData
    }
}
