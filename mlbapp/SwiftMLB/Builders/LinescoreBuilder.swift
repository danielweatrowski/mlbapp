//
//  LinescoreParser.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/8/23.
//

import Foundation

struct LinescoreBuilder: JSONBuilder {
    func build(with data: Data) throws -> [String : Any] {
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        guard let liveData = dict["liveData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        guard let linescore = liveData["linescore"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        guard let decisions = liveData["decisions"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "decisions")
        }
        guard let teams = linescore["teams"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "teams")
        }
        
        return [
            "innings": linescore["innings"] ?? [:],
            "teams": teams,
            "home": teams["home"] ?? [:],
            "away": teams["away"] ?? [:],
            "winner": decisions["winner"] ?? [:],
            "loser": decisions["loser"] ?? [:]
        ]
    }
}

