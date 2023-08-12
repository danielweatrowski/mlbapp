//
//  MLBStandings.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation

public struct MLBStandings: Decodable {
    
    public struct Record: Decodable {
//        let league: MLBLeague
//        let division: MLBDivision
        public let teamRecords: [TeamRecord]
    }
    
    public struct TeamRecord: Decodable {
        public let wins: Int
        public let losses: Int
        public let winningPercentage: String
        public let divisionRank: String
        public let wildCardRank: String?
        public let gamesBack: String
        public let wildCardGamesBack: String
        public let streak: Streak?
        public let team: MLBTeam
        public let records: RecordVariants
    }
    
    public struct Streak: Decodable {
        public let streakType: String
        public let streakNumber: Int
        public let streakCode: String
    }
    
    public struct RecordVariants: Decodable {
        public let splitRecords: [SplitRecord]?
    }
    
    public struct SplitRecord: Decodable {
        
        public let wins: Int
        public let losses: Int
        public let type: String
        public let pct: String
        
    }
    
   public let records: [MLBStandings.Record]
}
