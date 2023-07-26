//
//  MLBGameStatus.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/3/23.
//

import Foundation

public struct MLBGameStatus: Codable {
    public let statusCode: String
    public let detailedState: String
    public let abstractGameState: String
}
