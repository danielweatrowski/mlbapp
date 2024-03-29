//
//  MLBPlay.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/14/23.
//

import Foundation

struct MLBPlays: Decodable {
    let allPlays: [MLBPlay]
}

struct MLBPlay: Decodable {
    
    let result: Result
    let about: About
    
    struct Result: Decodable {
        let type: String
        let event: String?
        let eventType: String?
        let description: String?
        let rbi: Int?
        let awayScore: Int
        let homeScore: Int
        let isOut: Bool?
    }
    
    struct About: Decodable {
        let atBatIndex: Int
        let halfInning: String
        let inning: Int
        let startTime: Date
        let endTime: Date
        let hasOut: Bool
    }
}
