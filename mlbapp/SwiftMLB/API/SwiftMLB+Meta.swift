//
//  SwiftMLB+Meta.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import Foundation

extension SwiftMLB {
    static func meta(type: String) async throws -> Dictionary<String, Any> {
        let request: SwiftMLBRequest = .meta(type)

        let data = try await networkService.load(request)
        let builder =  PassThruBuilder()
        let json = try builder.build(with: data)
        
        return json
    }
}
