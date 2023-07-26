//
//  Dictionary+Extensions.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/9/22.
//

import Foundation

extension Dictionary {

    var json: String {
        let invalidJson = "INVALID JSON OBJECT"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }

    func printPretty() {
        print(json)
    }

}
