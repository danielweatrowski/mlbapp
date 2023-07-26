//
//  SwiftMLB+Content.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/14/23.
//

import Foundation

extension SwiftMLB {
    public static func content(gameID: Int) async throws -> MLBContent {
        let request: SwiftMLBRequest = .content(gameID)

        let data = try await networkService.load(request)
        let decoder = JSONDecoder()
        let content = try decoder.decode(MLBContent.self, from: data)
        
        return content
    }
}
