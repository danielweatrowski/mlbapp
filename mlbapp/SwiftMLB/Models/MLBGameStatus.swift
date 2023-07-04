//
//  MLBGameStatus.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/3/23.
//

import Foundation

struct MLBGameStatus: Codable {
    let statusCode: String
    let detailedState: String
    let abstractGameState: String
}
