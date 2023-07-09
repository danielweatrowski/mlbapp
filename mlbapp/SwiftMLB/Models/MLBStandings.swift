//
//  MLBStandings.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation

struct MLBStandings: Decodable {
    
    struct Record: Decodable {
//        let league: MLBLeague
//        let division: MLBDivision
        let teamRecords: [TeamRecord]
    }
    
    struct TeamRecord: Decodable {
        let wins: Int
        let losses: Int
        let winningPercentage: String
        let divisionRank: String
        let wildCardRank: String?
        let gamesBack: String
        let wildCardGamesBack: String
        let streak: Streak?
        let team: MLBTeam
    }
    
    struct Streak: Decodable {
        let streakType: String
        let streakNumber: Int
        let streakCode: String
    }
    
    let records: [MLBStandings.Record]
}
