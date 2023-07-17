//
//  Statistics.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/16/23.
//

import Foundation

enum Statistics {
    enum Batting {
        struct Game {
            let runs, doubles, triples, homeRuns, hits: Stat<Int>
            let strikeOuts, baseOnBalls, stolenBases: Stat<Int>
            let intentionalWalks, catchersInterference, caughtStealing: Stat<Int>
            let flyOuts, gamesPlayed, groundIntoDoublePlay, groundIntoTriplePlay: Stat<Int>
            let groundOuts, hitByPitch, pickOffs, plateAppearances: Stat<Int>
            let sacBunts, sacFlies, totalBases: Stat<Int>
            let atBats, rbi, leftOnBase: Stat<Int>
            let atBatsPerHomeRun, stolenBasePercentage, summary, note: Stat<String>
        }
        
        struct Season {
            let atBats, baseOnBalls, catcherInterference, caughtStealing: Stat<Int>
            let doubles, flyOuts, gamesPlayed: Stat<Int>
            let groundedIntoDoublePlay, groundedIntoTriplePlay, groundOuts: Stat<Int>
            let hitByPitch, hits, homeRuns: Stat<Int>
            let intentionalWalks, leftOnBase, pickOffs, plateAppearances: Stat<Int>
            let rbi, runs, sacBunts, sacFlies: Stat<Int>
            let stolenBases, strikeOuts, totalBases, triples: Stat<Int>
            
            let atBatsPerHomeRun, avg, babip, obp, ops: Stat<String>
            let slg, stolenBasePercentage: Stat<String>
        }
    }
    
    enum Pitching {
        struct Game {
            let note, summary: Stat<String>
            let gamesPlayed, gamesStarted, flyOuts, groundOuts: Stat<Int>
            let airOuts, runs, doubles, triples: Stat<Int>
            let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Stat<Int>
            let hits, hitByPitch, atBats, caughtStealing: Stat<Int>
            let stolenBases: Stat<Int>
            let stolenBasePercentage: Stat<String>
            let numberOfPitches: Stat<Int>
            let inningsPitched: Stat<String>
            let wins, losses, saves, saveOpportunities: Stat<Int>
            let holds, blownSaves, earnedRuns, battersFaced: Stat<Int>
            let outs, gamesPitched, completeGames, shutouts: Stat<Int>
            let pitchesThrown, balls, strikes: Stat<Int>
            let strikePercentage: Stat<String>
            let hitBatsmen, balks, wildPitches, pickoffs: Stat<Int>
            let rbi, gamesFinished: Stat<Int>
            let runsScoredPer9, homeRunsPer9: Stat<String>
            let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Stat<Int>
            let sacFlies, passedBall: Stat<Int>
        }
        
        struct Season {
            let gamesPlayed, gamesStarted, flyOuts, groundOuts: Stat<Int>
            let airOuts, runs, doubles, triples: Stat<Int>
            let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Stat<Int>
            let hits, hitByPitch, atBats: Stat<Int>
            let obp: Stat<String>
            let caughtStealing, stolenBases: Stat<Int>
            let stolenBasePercentage: Stat<String>
            let numberOfPitches: Stat<Int>
            let era, inningsPitched: Stat<String>
            let wins, losses, saves, saveOpportunities: Stat<Int>
            let holds, blownSaves, earnedRuns: Stat<Int>
            let whip: Stat<String>
            let battersFaced, outs, gamesPitched, completeGames: Stat<Int>
            let shutouts, pitchesThrown, balls, strikes: Stat<Int>
            let strikePercentage: Stat<String>
            let hitBatsmen, balks, wildPitches, pickoffs: Stat<Int>
            let groundOutsToAirouts: Stat<String>
            let rbi: Stat<Int>
            let winPercentage, pitchesPerInning: Stat<String>
            let gamesFinished: Stat<Int>
            let strikeoutWalkRatio, strikeoutsPer9Inn, walksPer9Inn, hitsPer9Inn: Stat<String>
            let runsScoredPer9, homeRunsPer9: Stat<String>
            let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Stat<Int>
            let sacFlies, passedBall: Stat<Int>
        }
    }
    
    enum Fielding {
        struct Game {
            let gamesStarted, caughtStealing, stolenBases: Stat<Int>
            let stolenBasePercentage: Stat<String>
            let assists, putOuts, errors, chances: Stat<Int>
            let fielding: Stat<String>
            let passedBall, pickoffs: Stat<Int>
        }
        
        struct Season {
            let gamesStarted, caughtStealing, stolenBases: Stat<Int>
            let stolenBasePercentage: Stat<String>
            let assists, putOuts, errors, chances: Stat<Int>
            let fielding: Stat<String>
            let passedBall, pickoffs: Stat<Int>
        }
    }
}


extension Statistics {
    struct GameStats {
        let batting: Batting.Game?
        let fielding: Fielding.Game?
        let pitching: Pitching.Game?
    }
    
    struct SeasonStats {
        let batting: Batting.Season?
        let fielding: Fielding.Season?
        let pitching: Pitching.Season?
    }
}
