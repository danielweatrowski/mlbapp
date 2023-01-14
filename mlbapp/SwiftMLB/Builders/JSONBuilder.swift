//
//  JSONBuilder.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

protocol JSONBuilder {
    func build(with data: Data) throws -> [String: Any]
}
