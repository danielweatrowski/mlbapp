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
        
        let parser = LinescoreParser(data: data)
        let linescore = try parser.parse()

        return linescore
    }
}
