//
//  MLBStatistics.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/7/23.
//

import Foundation

public enum MLBStatistics {
    public enum Batting {
        public struct GameStatistics: Codable {
            public let runs, doubles, triples, homeRuns, hits: Int?
            public let strikeOuts, baseOnBalls, stolenBases: Int?
            public let intentionalWalks, catchersInterference, caughtStealing: Int?
            public let flyOuts, gamesPlayed, groundIntoDoublePlay, groundIntoTriplePlay: Int?
            public let groundOuts, hitByPitch, pickOffs, plateAppearances: Int?
            public let sacBunts, sacFlies, totalBases: Int?
            public let atBats, rbi, leftOnBase: Int?
            public let atBatsPerHomeRun, stolenBasePercentage, summary, note: String?
        }
        
        public struct SeasonStatistics: Codable {
            public let atBats, baseOnBalls, catcherInterference, caughtStealing: Int?
            public let doubles, flyOuts, gamesPlayed: Int?
            public let groundedIntoDoublePlay, groundedIntoTriplePlay, groundOuts: Int?
            public let hitByPitch, hits, homeRuns: Int?
            public let intentionalWalks, leftOnBase, pickOffs, plateAppearances: Int?
            public let rbi, runs, sacBunts, sacFlies: Int?
            public let stolenBases, strikeOuts, totalBases, triples: Int?
            public let atBatsPerHomeRun, avg, babip, obp, ops: String?
            public let slg, stolenBasePercentage: String?
        }
    }
    
    public enum Pitching {
        public struct GameStatistics: Codable {
            public let note, summary: String?
            public let gamesPlayed, gamesStarted, flyOuts, groundOuts: Int?
            public let airOuts, runs, doubles, triples: Int?
            public let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Int?
            public let hits, hitByPitch, atBats, caughtStealing: Int?
            public let stolenBases: Int?
            public let stolenBasePercentage: String?
            public let numberOfPitches: Int?
            public let inningsPitched: String?
            public let wins, losses, saves, saveOpportunities: Int?
            public let holds, blownSaves, earnedRuns, battersFaced: Int?
            public let outs, gamesPitched, completeGames, shutouts: Int?
            public let pitchesThrown, balls, strikes: Int?
            public let strikePercentage: String?
            public let hitBatsmen, balks, wildPitches, pickoffs: Int?
            public let rbi, gamesFinished: Int?
            public let runsScoredPer9, homeRunsPer9: String?
            public let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Int?
            public let sacFlies, passedBall: Int?
        }
        
        public struct SeasonStatistics: Codable {
            public let gamesPlayed, gamesStarted, flyOuts, groundOuts: Int?
            public let airOuts, runs, doubles, triples: Int?
            public let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Int?
            public let hits, hitByPitch, atBats: Int?
            public let obp: String?
            public let caughtStealing, stolenBases: Int?
            public let stolenBasePercentage: String?
            public let numberOfPitches: Int?
            public let era, inningsPitched: String?
            public let wins, losses, saves, saveOpportunities: Int?
            public let holds, blownSaves, earnedRuns: Int?
            public let whip: String?
            public let battersFaced, outs, gamesPitched, completeGames: Int?
            public let shutouts, pitchesThrown, balls, strikes: Int?
            public let strikePercentage: String?
            public let hitBatsmen, balks, wildPitches, pickoffs: Int?
            public let groundOutsToAirouts: String?
            public let rbi: Int?
            public let winPercentage, pitchesPerInning: String?
            public let gamesFinished: Int?
            public let strikeoutWalkRatio, strikeoutsPer9Inn, walksPer9Inn, hitsPer9Inn: String?
            public let runsScoredPer9, homeRunsPer9: String?
            public let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Int?
            public let sacFlies, passedBall: Int?
        }
    }
    
    public enum Fielding {
        public struct GameStatistics: Codable {
            public let gamesStarted, caughtStealing, stolenBases: Int?
            public let stolenBasePercentage: String?
            public let assists, putOuts, errors, chances: Int?
            public let fielding: String?
            public let passedBall, pickoffs: Int?
        }
        
        public struct SeasonStatistics: Codable {
            public let gamesStarted, caughtStealing, stolenBases: Int?
            public let stolenBasePercentage: String?
            public let assists, putOuts, errors, chances: Int?
            public let fielding: String?
            public let passedBall, pickoffs: Int?
        }
    }
}


extension MLBStatistics {
    public struct GameStats: Codable {
        public let batting: Batting.GameStatistics?
        public let fielding: Fielding.GameStatistics?
        public let pitching: Pitching.GameStatistics?
    }
    
    public struct TotalStats: Codable {
        public let batting: Batting.SeasonStatistics?
        public let fielding: Fielding.SeasonStatistics?
        public let pitching: Pitching.SeasonStatistics?
    }
}
