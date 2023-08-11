//
//  Statistics.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/16/23.
//

import Foundation

public enum Statistics {
    public enum Batting {
        public struct Game {
            
            public let runs, doubles, triples, homeRuns, hits: Stat<Int>
            public let strikeOuts, baseOnBalls, stolenBases: Stat<Int>
            public let intentionalWalks, catchersInterference, caughtStealing: Stat<Int>
            public let flyOuts, gamesPlayed, groundIntoDoublePlay, groundIntoTriplePlay: Stat<Int>
            public let groundOuts, hitByPitch, pickOffs, plateAppearances: Stat<Int>
            public let sacBunts, sacFlies, totalBases: Stat<Int>
            public let atBats, rbi, leftOnBase: Stat<Int>
            public let atBatsPerHomeRun, stolenBasePercentage, summary, note: Stat<String>
            
            public init(runs: Stat<Int>, doubles: Stat<Int>, triples: Stat<Int>, homeRuns: Stat<Int>, hits: Stat<Int>, strikeOuts: Stat<Int>, baseOnBalls: Stat<Int>, stolenBases: Stat<Int>, intentionalWalks: Stat<Int>, catchersInterference: Stat<Int>, caughtStealing: Stat<Int>, flyOuts: Stat<Int>, gamesPlayed: Stat<Int>, groundIntoDoublePlay: Stat<Int>, groundIntoTriplePlay: Stat<Int>, groundOuts: Stat<Int>, hitByPitch: Stat<Int>, pickOffs: Stat<Int>, plateAppearances: Stat<Int>, sacBunts: Stat<Int>, sacFlies: Stat<Int>, totalBases: Stat<Int>, atBats: Stat<Int>, rbi: Stat<Int>, leftOnBase: Stat<Int>, atBatsPerHomeRun: Stat<String>, stolenBasePercentage: Stat<String>, summary: Stat<String>, note: Stat<String>) {
                self.runs = runs
                self.doubles = doubles
                self.triples = triples
                self.homeRuns = homeRuns
                self.hits = hits
                self.strikeOuts = strikeOuts
                self.baseOnBalls = baseOnBalls
                self.stolenBases = stolenBases
                self.intentionalWalks = intentionalWalks
                self.catchersInterference = catchersInterference
                self.caughtStealing = caughtStealing
                self.flyOuts = flyOuts
                self.gamesPlayed = gamesPlayed
                self.groundIntoDoublePlay = groundIntoDoublePlay
                self.groundIntoTriplePlay = groundIntoTriplePlay
                self.groundOuts = groundOuts
                self.hitByPitch = hitByPitch
                self.pickOffs = pickOffs
                self.plateAppearances = plateAppearances
                self.sacBunts = sacBunts
                self.sacFlies = sacFlies
                self.totalBases = totalBases
                self.atBats = atBats
                self.rbi = rbi
                self.leftOnBase = leftOnBase
                self.atBatsPerHomeRun = atBatsPerHomeRun
                self.stolenBasePercentage = stolenBasePercentage
                self.summary = summary
                self.note = note
            }
        }
        
        public struct Season {
            
            public let atBats, baseOnBalls, catcherInterference, caughtStealing: Stat<Int>
            public let doubles, flyOuts, gamesPlayed: Stat<Int>
            public let groundedIntoDoublePlay, groundedIntoTriplePlay, groundOuts: Stat<Int>
            public let hitByPitch, hits, homeRuns: Stat<Int>
            public let intentionalWalks, leftOnBase, pickOffs, plateAppearances: Stat<Int>
            public let rbi, runs, sacBunts, sacFlies: Stat<Int>
            public let stolenBases, strikeOuts, totalBases, triples: Stat<Int>
             
            public let atBatsPerHomeRun, avg, babip, obp, ops: Stat<String>
            public let slg, stolenBasePercentage: Stat<String>
            
            public init(atBats: Stat<Int>, baseOnBalls: Stat<Int>, catcherInterference: Stat<Int>, caughtStealing: Stat<Int>, doubles: Stat<Int>, flyOuts: Stat<Int>, gamesPlayed: Stat<Int>, groundedIntoDoublePlay: Stat<Int>, groundedIntoTriplePlay: Stat<Int>, groundOuts: Stat<Int>, hitByPitch: Stat<Int>, hits: Stat<Int>, homeRuns: Stat<Int>, intentionalWalks: Stat<Int>, leftOnBase: Stat<Int>, pickOffs: Stat<Int>, plateAppearances: Stat<Int>, rbi: Stat<Int>, runs: Stat<Int>, sacBunts: Stat<Int>, sacFlies: Stat<Int>, stolenBases: Stat<Int>, strikeOuts: Stat<Int>, totalBases: Stat<Int>, triples: Stat<Int>, atBatsPerHomeRun: Stat<String>, avg: Stat<String>, babip: Stat<String>, obp: Stat<String>, ops: Stat<String>, slg: Stat<String>, stolenBasePercentage: Stat<String>) {
                self.atBats = atBats
                self.baseOnBalls = baseOnBalls
                self.catcherInterference = catcherInterference
                self.caughtStealing = caughtStealing
                self.doubles = doubles
                self.flyOuts = flyOuts
                self.gamesPlayed = gamesPlayed
                self.groundedIntoDoublePlay = groundedIntoDoublePlay
                self.groundedIntoTriplePlay = groundedIntoTriplePlay
                self.groundOuts = groundOuts
                self.hitByPitch = hitByPitch
                self.hits = hits
                self.homeRuns = homeRuns
                self.intentionalWalks = intentionalWalks
                self.leftOnBase = leftOnBase
                self.pickOffs = pickOffs
                self.plateAppearances = plateAppearances
                self.rbi = rbi
                self.runs = runs
                self.sacBunts = sacBunts
                self.sacFlies = sacFlies
                self.stolenBases = stolenBases
                self.strikeOuts = strikeOuts
                self.totalBases = totalBases
                self.triples = triples
                self.atBatsPerHomeRun = atBatsPerHomeRun
                self.avg = avg
                self.babip = babip
                self.obp = obp
                self.ops = ops
                self.slg = slg
                self.stolenBasePercentage = stolenBasePercentage
            }
        }
    }
    
    public enum Pitching {
        public struct Game {
            
            public let note, summary: Stat<String>
            public let gamesPlayed, gamesStarted, flyOuts, groundOuts: Stat<Int>
            public let airOuts, runs, doubles, triples: Stat<Int>
            public let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Stat<Int>
            public let hits, hitByPitch, atBats, caughtStealing: Stat<Int>
            public let stolenBases: Stat<Int>
            public let stolenBasePercentage: Stat<String>
            public let numberOfPitches: Stat<Int>
            public let inningsPitched: Stat<String>
            public let wins, losses, saves, saveOpportunities: Stat<Int>
            public let holds, blownSaves, earnedRuns, battersFaced: Stat<Int>
            public let outs, gamesPitched, completeGames, shutouts: Stat<Int>
            public let pitchesThrown, balls, strikes: Stat<Int>
            public let strikePercentage: Stat<String>
            public let hitBatsmen, balks, wildPitches, pickoffs: Stat<Int>
            public let rbi, gamesFinished: Stat<Int>
            public let runsScoredPer9, homeRunsPer9: Stat<String>
            public let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Stat<Int>
            public let sacFlies, passedBall: Stat<Int>
            
            public init(note: Stat<String>, summary: Stat<String>, gamesPlayed: Stat<Int>, gamesStarted: Stat<Int>, flyOuts: Stat<Int>, groundOuts: Stat<Int>, airOuts: Stat<Int>, runs: Stat<Int>, doubles: Stat<Int>, triples: Stat<Int>, homeRuns: Stat<Int>, strikeOuts: Stat<Int>, baseOnBalls: Stat<Int>, intentionalWalks: Stat<Int>, hits: Stat<Int>, hitByPitch: Stat<Int>, atBats: Stat<Int>, caughtStealing: Stat<Int>, stolenBases: Stat<Int>, stolenBasePercentage: Stat<String>, numberOfPitches: Stat<Int>, inningsPitched: Stat<String>, wins: Stat<Int>, losses: Stat<Int>, saves: Stat<Int>, saveOpportunities: Stat<Int>, holds: Stat<Int>, blownSaves: Stat<Int>, earnedRuns: Stat<Int>, battersFaced: Stat<Int>, outs: Stat<Int>, gamesPitched: Stat<Int>, completeGames: Stat<Int>, shutouts: Stat<Int>, pitchesThrown: Stat<Int>, balls: Stat<Int>, strikes: Stat<Int>, strikePercentage: Stat<String>, hitBatsmen: Stat<Int>, balks: Stat<Int>, wildPitches: Stat<Int>, pickoffs: Stat<Int>, rbi: Stat<Int>, gamesFinished: Stat<Int>, runsScoredPer9: Stat<String>, homeRunsPer9: Stat<String>, inheritedRunners: Stat<Int>, inheritedRunnersScored: Stat<Int>, catchersInterference: Stat<Int>, sacBunts: Stat<Int>, sacFlies: Stat<Int>, passedBall: Stat<Int>) {
                self.note = note
                self.summary = summary
                self.gamesPlayed = gamesPlayed
                self.gamesStarted = gamesStarted
                self.flyOuts = flyOuts
                self.groundOuts = groundOuts
                self.airOuts = airOuts
                self.runs = runs
                self.doubles = doubles
                self.triples = triples
                self.homeRuns = homeRuns
                self.strikeOuts = strikeOuts
                self.baseOnBalls = baseOnBalls
                self.intentionalWalks = intentionalWalks
                self.hits = hits
                self.hitByPitch = hitByPitch
                self.atBats = atBats
                self.caughtStealing = caughtStealing
                self.stolenBases = stolenBases
                self.stolenBasePercentage = stolenBasePercentage
                self.numberOfPitches = numberOfPitches
                self.inningsPitched = inningsPitched
                self.wins = wins
                self.losses = losses
                self.saves = saves
                self.saveOpportunities = saveOpportunities
                self.holds = holds
                self.blownSaves = blownSaves
                self.earnedRuns = earnedRuns
                self.battersFaced = battersFaced
                self.outs = outs
                self.gamesPitched = gamesPitched
                self.completeGames = completeGames
                self.shutouts = shutouts
                self.pitchesThrown = pitchesThrown
                self.balls = balls
                self.strikes = strikes
                self.strikePercentage = strikePercentage
                self.hitBatsmen = hitBatsmen
                self.balks = balks
                self.wildPitches = wildPitches
                self.pickoffs = pickoffs
                self.rbi = rbi
                self.gamesFinished = gamesFinished
                self.runsScoredPer9 = runsScoredPer9
                self.homeRunsPer9 = homeRunsPer9
                self.inheritedRunners = inheritedRunners
                self.inheritedRunnersScored = inheritedRunnersScored
                self.catchersInterference = catchersInterference
                self.sacBunts = sacBunts
                self.sacFlies = sacFlies
                self.passedBall = passedBall
            }
        }
        
        public struct Season {
            
            public let gamesPlayed, gamesStarted, flyOuts, groundOuts: Stat<Int>
            public let airOuts, runs, doubles, triples: Stat<Int>
            public let homeRuns, strikeOuts, baseOnBalls, intentionalWalks: Stat<Int>
            public let hits, hitByPitch, atBats: Stat<Int>
            public let obp: Stat<String>
            public let caughtStealing, stolenBases: Stat<Int>
            public let stolenBasePercentage: Stat<String>
            public let numberOfPitches: Stat<Int>
            public let era, inningsPitched: Stat<String>
            public let wins, losses, saves, saveOpportunities: Stat<Int>
            public let holds, blownSaves, earnedRuns: Stat<Int>
            public let whip: Stat<String>
            public let battersFaced, outs, gamesPitched, completeGames: Stat<Int>
            public let shutouts, pitchesThrown, balls, strikes: Stat<Int>
            public let strikePercentage: Stat<String>
            public let hitBatsmen, balks, wildPitches, pickoffs: Stat<Int>
            public let groundOutsToAirouts: Stat<String>
            public let rbi: Stat<Int>
            public let winPercentage, pitchesPerInning: Stat<String>
            public let gamesFinished: Stat<Int>
            public let strikeoutWalkRatio, strikeoutsPer9Inn, walksPer9Inn, hitsPer9Inn: Stat<String>
            public let runsScoredPer9, homeRunsPer9: Stat<String>
            public let inheritedRunners, inheritedRunnersScored, catchersInterference, sacBunts: Stat<Int>
            public let sacFlies, passedBall: Stat<Int>
            
            public init(gamesPlayed: Stat<Int>, gamesStarted: Stat<Int>, flyOuts: Stat<Int>, groundOuts: Stat<Int>, airOuts: Stat<Int>, runs: Stat<Int>, doubles: Stat<Int>, triples: Stat<Int>, homeRuns: Stat<Int>, strikeOuts: Stat<Int>, baseOnBalls: Stat<Int>, intentionalWalks: Stat<Int>, hits: Stat<Int>, hitByPitch: Stat<Int>, atBats: Stat<Int>, obp: Stat<String>, caughtStealing: Stat<Int>, stolenBases: Stat<Int>, stolenBasePercentage: Stat<String>, numberOfPitches: Stat<Int>, era: Stat<String>, inningsPitched: Stat<String>, wins: Stat<Int>, losses: Stat<Int>, saves: Stat<Int>, saveOpportunities: Stat<Int>, holds: Stat<Int>, blownSaves: Stat<Int>, earnedRuns: Stat<Int>, whip: Stat<String>, battersFaced: Stat<Int>, outs: Stat<Int>, gamesPitched: Stat<Int>, completeGames: Stat<Int>, shutouts: Stat<Int>, pitchesThrown: Stat<Int>, balls: Stat<Int>, strikes: Stat<Int>, strikePercentage: Stat<String>, hitBatsmen: Stat<Int>, balks: Stat<Int>, wildPitches: Stat<Int>, pickoffs: Stat<Int>, groundOutsToAirouts: Stat<String>, rbi: Stat<Int>, winPercentage: Stat<String>, pitchesPerInning: Stat<String>, gamesFinished: Stat<Int>, strikeoutWalkRatio: Stat<String>, strikeoutsPer9Inn: Stat<String>, walksPer9Inn: Stat<String>, hitsPer9Inn: Stat<String>, runsScoredPer9: Stat<String>, homeRunsPer9: Stat<String>, inheritedRunners: Stat<Int>, inheritedRunnersScored: Stat<Int>, catchersInterference: Stat<Int>, sacBunts: Stat<Int>, sacFlies: Stat<Int>, passedBall: Stat<Int>) {
                self.gamesPlayed = gamesPlayed
                self.gamesStarted = gamesStarted
                self.flyOuts = flyOuts
                self.groundOuts = groundOuts
                self.airOuts = airOuts
                self.runs = runs
                self.doubles = doubles
                self.triples = triples
                self.homeRuns = homeRuns
                self.strikeOuts = strikeOuts
                self.baseOnBalls = baseOnBalls
                self.intentionalWalks = intentionalWalks
                self.hits = hits
                self.hitByPitch = hitByPitch
                self.atBats = atBats
                self.obp = obp
                self.caughtStealing = caughtStealing
                self.stolenBases = stolenBases
                self.stolenBasePercentage = stolenBasePercentage
                self.numberOfPitches = numberOfPitches
                self.era = era
                self.inningsPitched = inningsPitched
                self.wins = wins
                self.losses = losses
                self.saves = saves
                self.saveOpportunities = saveOpportunities
                self.holds = holds
                self.blownSaves = blownSaves
                self.earnedRuns = earnedRuns
                self.whip = whip
                self.battersFaced = battersFaced
                self.outs = outs
                self.gamesPitched = gamesPitched
                self.completeGames = completeGames
                self.shutouts = shutouts
                self.pitchesThrown = pitchesThrown
                self.balls = balls
                self.strikes = strikes
                self.strikePercentage = strikePercentage
                self.hitBatsmen = hitBatsmen
                self.balks = balks
                self.wildPitches = wildPitches
                self.pickoffs = pickoffs
                self.groundOutsToAirouts = groundOutsToAirouts
                self.rbi = rbi
                self.winPercentage = winPercentage
                self.pitchesPerInning = pitchesPerInning
                self.gamesFinished = gamesFinished
                self.strikeoutWalkRatio = strikeoutWalkRatio
                self.strikeoutsPer9Inn = strikeoutsPer9Inn
                self.walksPer9Inn = walksPer9Inn
                self.hitsPer9Inn = hitsPer9Inn
                self.runsScoredPer9 = runsScoredPer9
                self.homeRunsPer9 = homeRunsPer9
                self.inheritedRunners = inheritedRunners
                self.inheritedRunnersScored = inheritedRunnersScored
                self.catchersInterference = catchersInterference
                self.sacBunts = sacBunts
                self.sacFlies = sacFlies
                self.passedBall = passedBall
            }
            
            public var record: Stat<String> {
                
                guard let seasonWins = wins.value, let seasonLosses = losses.value else {
                    return .init(value: nil)
                }
                return .init(value: "\(seasonWins)-\(seasonLosses)")
                
            }
        }
    }
    
    public enum Fielding {
        public struct Game {
            
            public let gamesStarted, caughtStealing, stolenBases: Stat<Int>
            public let stolenBasePercentage: Stat<String>
            public let assists, putOuts, errors, chances: Stat<Int>
            public let fielding: Stat<String>
            public let passedBall, pickoffs: Stat<Int>
            
            public init(gamesStarted: Stat<Int>, caughtStealing: Stat<Int>, stolenBases: Stat<Int>, stolenBasePercentage: Stat<String>, assists: Stat<Int>, putOuts: Stat<Int>, errors: Stat<Int>, chances: Stat<Int>, fielding: Stat<String>, passedBall: Stat<Int>, pickoffs: Stat<Int>) {
                self.gamesStarted = gamesStarted
                self.caughtStealing = caughtStealing
                self.stolenBases = stolenBases
                self.stolenBasePercentage = stolenBasePercentage
                self.assists = assists
                self.putOuts = putOuts
                self.errors = errors
                self.chances = chances
                self.fielding = fielding
                self.passedBall = passedBall
                self.pickoffs = pickoffs
            }
        }
        
        public struct Season {
            
            public let gamesStarted, caughtStealing, stolenBases: Stat<Int>
            public let stolenBasePercentage: Stat<String>
            public let assists, putOuts, errors, chances: Stat<Int>
            public let fielding: Stat<String>
            public let passedBall, pickoffs: Stat<Int>
            
            public init(gamesStarted: Stat<Int>, caughtStealing: Stat<Int>, stolenBases: Stat<Int>, stolenBasePercentage: Stat<String>, assists: Stat<Int>, putOuts: Stat<Int>, errors: Stat<Int>, chances: Stat<Int>, fielding: Stat<String>, passedBall: Stat<Int>, pickoffs: Stat<Int>) {
                self.gamesStarted = gamesStarted
                self.caughtStealing = caughtStealing
                self.stolenBases = stolenBases
                self.stolenBasePercentage = stolenBasePercentage
                self.assists = assists
                self.putOuts = putOuts
                self.errors = errors
                self.chances = chances
                self.fielding = fielding
                self.passedBall = passedBall
                self.pickoffs = pickoffs
            }
        }
    }
}


extension Statistics {
    public struct GameStats {
        
        public let batting: Batting.Game?
        public let fielding: Fielding.Game?
        public let pitching: Pitching.Game?
        
        public init(batting: Statistics.Batting.Game? = nil, fielding: Statistics.Fielding.Game? = nil, pitching: Statistics.Pitching.Game? = nil) {
            self.batting = batting
            self.fielding = fielding
            self.pitching = pitching
        }
    }
    
    public struct SeasonStats {
        
        public let batting: Batting.Season?
        public let fielding: Fielding.Season?
        public let pitching: Pitching.Season?
        
        public init(batting: Statistics.Batting.Season? = nil, fielding: Statistics.Fielding.Season? = nil, pitching: Statistics.Pitching.Season? = nil) {
            self.batting = batting
            self.fielding = fielding
            self.pitching = pitching
        }
    }
}
