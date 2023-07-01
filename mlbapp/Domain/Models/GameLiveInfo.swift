//
//  GameLiveInfo.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

struct GameLiveInfo: Codable {
    let currentInning: Int
    let inningState: String
    let currentInningDescription: String
    let currentInningHalf: String
}
