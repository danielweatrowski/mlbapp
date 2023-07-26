//
//  PlaysBuilder.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/14/23.
//

import Foundation


struct PlaysBuilder: JSONBuilder {
    func build(with data: Data) throws -> [String : Any] {
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        
        guard let liveData = dict["liveData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        guard let playsJSON = liveData["plays"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData.plays")
        }
        
        playsJSON.printPretty()
        return playsJSON
    }
}
