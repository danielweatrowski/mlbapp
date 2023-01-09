//
//  LinescoreParser.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/8/23.
//

import Foundation

struct LinescoreParser: Parser {
    var data: Data
    
    func parse() throws -> [String: Any] {
        
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        guard let liveData = dict["liveData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        guard let linescore = liveData["linescore"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        
        return linescore
    }

    
}
