//
//  GameLiveInfo.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

public struct GameLiveInfo: Codable {
    
    public init(currentInning: Int, inningState: String, currentInningDescription: String, currentInningHalf: String) {
        self.currentInning = currentInning
        self.inningState = inningState
        self.currentInningDescription = currentInningDescription
        self.currentInningHalf = currentInningHalf
    }
    
    public let currentInning: Int
    public let inningState: String
    public let currentInningDescription: String
    public let currentInningHalf: String
}
