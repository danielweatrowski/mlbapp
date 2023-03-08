//
//  MLBStatistics.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/7/23.
//

import Foundation

enum MLBStatistics {
    enum Batting {
        struct GameStatistics {
            let runs, doubles, triples, homeRuns, hits: Int?
            let strikeOuts, baseOnBalls, stolenBases: Int?
            let intentionalWalks, catchersInterference, caughtStealing: Int?
            let flyOuts, gamesPlayed, groundIntoDoublePlay, groundIntoTriplePlay: Int?
            let groundOuts, hitByPitch, pickOffs, plateAppearances: Int?
            let sacBunts, sacFlies, totalBases: Int?
            let atBats, rbi, leftOnBase: Int?
            let atBatsPerHomeRun, stolenBasePercentage, summary, note: String?
        }
        
        struct SeasonStatistics {
            let atBats, baseOnBalls, catcherInterference, caughtStealing: Int?
            let doubles, flyOuts, gamesPlayed: Int?
            let groundedIntoDoublePlay, groundedIntoTriplePlay, groundOuts: Int?
            let hitByPitch, hits, homeRuns: Int?
            let intentionalWalks, leftOnBase, pickOffs, plateAppearances: Int?
            let rbi, runs, sacBunts, sacFlies: Int?
            let stolenBases, strikeOuts, totalBases, triples: Int?
            
            let atBatsPerHomeRun, avg, babip, obp, ops: String?
            let slg, stolenBasePercentage: String?
        }
    }
    
    enum Pitching {
        struct GameStatistics {
            let note, summary: String?
            let gamesPlayed, gamesStarted, flyOuts, groundOuts: Int?
            let airOuts, runs, doubles, triples: Int?
            let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Int?
            let hits, hitByPitch, atBats, caughtStealing: Int?
            let stolenBases: Int?
            let stolenBasePercentage: String?
            let numberOfPitches: Int?
            let inningsPitched: String?
            let wins, losses, saves, saveOpportunities: Int?
            let holds, blownSaves, earnedRuns, battersFaced: Int?
            let outs, gamesPitched, completeGames, shutouts: Int?
            let pitchesThrown, balls, strikes: Int?
            let strikePercentage: String?
            let hitBatsmen, balks, wildPitches, pickoffs: Int?
            let rbi, gamesFinished: Int?
            let runsScoredPer9, homeRunsPer9: String?
            let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Int?
            let sacFlies, passedBall: Int?
        }
        
        struct SeasonStatistics {
            let gamesPlayed, gamesStarted, flyOuts, groundOuts: Int?
            let airOuts, runs, doubles, triples: Int?
            let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Int?
            let hits, hitByPitch, atBats: Int?
            let obp: String?
            let caughtStealing, stolenBases: Int?
            let stolenBasePercentage: String?
            let numberOfPitches: Int?
            let era, inningsPitched: String?
            let wins, losses, saves, saveOpportunities: Int?
            let holds, blownSaves, earnedRuns: Int?
            let whip: String?
            let battersFaced, outs, gamesPitched, completeGames: Int?
            let shutouts, pitchesThrown, balls, strikes: Int?
            let strikePercentage: String?
            let hitBatsmen, balks, wildPitches, pickoffs: Int?
            let groundOutsToAirouts: String?
            let rbi: Int?
            let winPercentage, pitchesPerInning: String?
            let gamesFinished: Int?
            let strikeoutWalkRatio, strikeoutsPer9Inn, walksPer9Inn, hitsPer9Inn: String?
            let runsScoredPer9, homeRunsPer9: String?
            let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Int?
            let sacFlies, passedBall: Int?
        }
    }
    
    enum Fielding {
        struct GameStatistics {
            let gamesStarted, caughtStealing, stolenBases: Int?
            let stolenBasePercentage: String?
            let assists, putOuts, errors, chances: Int?
            let fielding: String?
            let passedBall, pickoffs: Int?
        }
        
        struct SeasonStatistics {
            let gamesStarted, caughtStealing, stolenBases: Int?
            let stolenBasePercentage: String?
            let assists, putOuts, errors, chances: Int?
            let fielding: String?
            let passedBall, pickoffs: Int?
        }
    }
}
