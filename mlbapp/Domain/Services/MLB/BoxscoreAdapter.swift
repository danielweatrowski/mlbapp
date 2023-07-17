//
//  BoxscoreAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/10/23.
//

import Foundation

struct BoxscoreAdapter {
    
    let dataObject: MLBBoxscore_V2
    
    func toDomain() -> Boxscore_V2 {
        let boxscore = dataObject
        
        let h_team = boxscore.teams.home
        let a_team = boxscore.teams.away
        
        let homeTeam = Boxscore_V2.Team(id: h_team.team.id,
                                        name: h_team.team.name,
                                        teamStats: formatStats(from: h_team.teamStats),
                                        players: formatPlayers(from: h_team.players),
                                        batters: formatPlayerKeys(h_team.batters),
                                        pitchers: formatPlayerKeys(h_team.pitchers),
                                        bench: formatPlayerKeys(h_team.bench),
                                        battingOrder: formatPlayerKeys(h_team.battingOrder),
                                        info: formatInfo(from: h_team.info),
                                        note: formatNotes(from: h_team.note))
        
        let awayTeam = Boxscore_V2.Team(id: a_team.team.id,
                                        name: a_team.team.name,
                                        teamStats: formatStats(from: a_team.teamStats),
                                        players: formatPlayers(from: a_team.players),
                                        batters: formatPlayerKeys(a_team.batters),
                                        pitchers: formatPlayerKeys(a_team.pitchers),
                                        bench: formatPlayerKeys(a_team.bench),
                                        battingOrder: formatPlayerKeys(a_team.battingOrder),
                                        info: formatInfo(from: a_team.info),
                                        note: formatNotes(from: a_team.note))
        
        
        return Boxscore_V2(away: awayTeam,
                           home: homeTeam)
    }
    
    private func formatPlayerKeys(_ ids: [Int]?) -> [String] {
        if let ids = ids {
            return ids.map { "ID\($0)" }
        }
        
        return []
    }
    
    private func formatStats(from statsDTO: MLBStatistics.GameStats?) -> Statistics.GameStats {
        return Statistics.GameStats(batting: formatBattingStats(from: statsDTO?.batting),
                                      fielding: formatFieldingStats(from: statsDTO?.fielding),
                                      pitching: formatPitchingStats(from: statsDTO?.pitching))
    }
    
    private func formatBattingStats(from statsDTO: MLBStatistics.Batting.GameStatistics?) -> Statistics.Batting.Game {
        return Statistics.Batting.Game(runs: .init(value: statsDTO?.runs),
                                       doubles: .init(value: statsDTO?.doubles),
                                       triples: .init(value: statsDTO?.triples),
                                       homeRuns: .init(value: statsDTO?.homeRuns),
                                       hits: .init(value: statsDTO?.hits),
                                       strikeOuts: .init(value: statsDTO?.strikeOuts),
                                       baseOnBalls: .init(value: statsDTO?.baseOnBalls),
                                       stolenBases: .init(value: statsDTO?.stolenBases),
                                       intentionalWalks: .init(value: statsDTO?.intentionalWalks),
                                       catchersInterference: .init(value: statsDTO?.catchersInterference),
                                       caughtStealing: .init(value: statsDTO?.caughtStealing),
                                       flyOuts: .init(value: statsDTO?.flyOuts),
                                       gamesPlayed: .init(value: statsDTO?.gamesPlayed),
                                       groundIntoDoublePlay: .init(value: statsDTO?.groundIntoDoublePlay),
                                       groundIntoTriplePlay: .init(value: statsDTO?.groundIntoTriplePlay),
                                       groundOuts: .init(value: statsDTO?.groundOuts),
                                       hitByPitch: .init(value: statsDTO?.hitByPitch),
                                       pickOffs: .init(value: statsDTO?.pickOffs),
                                       plateAppearances: .init(value: statsDTO?.plateAppearances),
                                       sacBunts: .init(value: statsDTO?.sacBunts),
                                       sacFlies: .init(value: statsDTO?.sacFlies),
                                       totalBases: .init(value: statsDTO?.totalBases),
                                       atBats: .init(value: statsDTO?.atBats),
                                       rbi: .init(value: statsDTO?.rbi),
                                       leftOnBase: .init(value: statsDTO?.leftOnBase),
                                       atBatsPerHomeRun: .init(value: statsDTO?.atBatsPerHomeRun),
                                       stolenBasePercentage: .init(value: statsDTO?.stolenBasePercentage),
                                       summary: .init(value: statsDTO?.summary),
                                       note: .init(value: statsDTO?.note))
    }
    
    private func formatFieldingStats(from statsDTO: MLBStatistics.Fielding.GameStatistics?) -> Statistics.Fielding.Game {
        return Statistics.Fielding.Game(gamesStarted: .init(value: statsDTO?.gamesStarted),
                                        caughtStealing: .init(value: statsDTO?.caughtStealing),
                                        stolenBases: .init(value: statsDTO?.stolenBases),
                                        stolenBasePercentage: .init(value: statsDTO?.stolenBasePercentage),
                                        assists: .init(value: statsDTO?.assists),
                                        putOuts: .init(value: statsDTO?.putOuts),
                                        errors: .init(value: statsDTO?.errors),
                                        chances: .init(value: statsDTO?.chances),
                                        fielding: .init(value: statsDTO?.fielding),
                                        passedBall: .init(value: statsDTO?.passedBall),
                                        pickoffs: .init(value: statsDTO?.pickoffs))
    }
    
    private func formatPitchingStats(from statsDTO: MLBStatistics.Pitching.GameStatistics?) -> Statistics.Pitching.Game {
        return Statistics.Pitching.Game(note: .init(value: statsDTO?.note),
                                        summary: .init(value: statsDTO?.summary),
                                        gamesPlayed: .init(value: statsDTO?.gamesPlayed),
                                        gamesStarted: .init(value: statsDTO?.gamesStarted),
                                        flyOuts: .init(value: statsDTO?.flyOuts),
                                        groundOuts: .init(value: statsDTO?.groundOuts),
                                        airOuts: .init(value: statsDTO?.airOuts),
                                        runs: .init(value: statsDTO?.runs),
                                        doubles: .init(value: statsDTO?.doubles),
                                        triples: .init(value: statsDTO?.triples),
                                        homeRuns: .init(value: statsDTO?.homeRuns),
                                        strikeOuts: .init(value: statsDTO?.strikeOuts),
                                        baseOnBalls: .init(value: statsDTO?.baseOnBalls),
                                        intentionalWalks: .init(value: statsDTO?.intentionalWalks),
                                        hits: .init(value: statsDTO?.hits),
                                        hitByPitch: .init(value: statsDTO?.hitByPitch),
                                        atBats: .init(value: statsDTO?.atBats),
                                        caughtStealing: .init(value: statsDTO?.caughtStealing),
                                        stolenBases: .init(value: statsDTO?.stolenBases),
                                        stolenBasePercentage: .init(value: statsDTO?.stolenBasePercentage),
                                        numberOfPitches: .init(value: statsDTO?.numberOfPitches),
                                        inningsPitched: .init(value: statsDTO?.inningsPitched),
                                        wins: .init(value: statsDTO?.wins),
                                        losses: .init(value: statsDTO?.losses),
                                        saves: .init(value: statsDTO?.saves),
                                        saveOpportunities: .init(value: statsDTO?.saveOpportunities),
                                        holds: .init(value: statsDTO?.holds),
                                        blownSaves: .init(value: statsDTO?.blownSaves),
                                        earnedRuns: .init(value: statsDTO?.earnedRuns),
                                        battersFaced: .init(value: statsDTO?.battersFaced),
                                        outs: .init(value: statsDTO?.outs),
                                        gamesPitched: .init(value: statsDTO?.gamesPitched),
                                        completeGames: .init(value: statsDTO?.completeGames),
                                        shutouts: .init(value: statsDTO?.shutouts),
                                        pitchesThrown: .init(value: statsDTO?.pitchesThrown),
                                        balls: .init(value: statsDTO?.balls),
                                        strikes: .init(value: statsDTO?.strikes),
                                        strikePercentage: .init(value: statsDTO?.strikePercentage),
                                        hitBatsmen: .init(value: statsDTO?.hitBatsmen),
                                        balks: .init(value: statsDTO?.balks),
                                        wildPitches: .init(value: statsDTO?.wildPitches),
                                        pickoffs: .init(value: statsDTO?.pickoffs),
                                        rbi: .init(value: statsDTO?.rbi),
                                        gamesFinished: .init(value: statsDTO?.gamesFinished),
                                        runsScoredPer9: .init(value: statsDTO?.runsScoredPer9),
                                        homeRunsPer9: .init(value: statsDTO?.homeRunsPer9),
                                        inheritedRunners:.init(value: statsDTO?.inheritedRunners),
                                        inheritedRunnersScored: .init(value: statsDTO?.inheritedRunnersScored),
                                        catchersInterference: .init(value: statsDTO?.catchersInterference),
                                        sacBunts: .init(value: statsDTO?.sacBunts),
                                        sacFlies: .init(value: statsDTO?.sacFlies),
                                        passedBall: .init(value: statsDTO?.passedBall))
    }
    
    private func formatStats(from statsDTO: MLBStatistics.TotalStats?) -> Statistics.SeasonStats {
        return Statistics.SeasonStats(batting: formatBattingStats(from: statsDTO?.batting),
                                      fielding: formatFieldingStats(from: statsDTO?.fielding),
                                      pitching: formatPitchingStats(from: statsDTO?.pitching))
    }
    
    private func formatBattingStats(from statsDTO: MLBStatistics.Batting.SeasonStatistics?) -> Statistics.Batting.Season {
        return Statistics.Batting.Season(atBats: .init(value: statsDTO?.atBats),
                                         baseOnBalls: .init(value: statsDTO?.catcherInterference),
                                         catcherInterference: .init(value: statsDTO?.catcherInterference),
                                         caughtStealing: .init(value: statsDTO?.caughtStealing),
                                         doubles: .init(value: statsDTO?.doubles),
                                         flyOuts: .init(value: statsDTO?.flyOuts),
                                         gamesPlayed: .init(value: statsDTO?.gamesPlayed),
                                         groundedIntoDoublePlay: .init(value: statsDTO?.groundedIntoDoublePlay),
                                         groundedIntoTriplePlay: .init(value: statsDTO?.groundedIntoTriplePlay),
                                         groundOuts: .init(value: statsDTO?.groundOuts),
                                         hitByPitch: .init(value: statsDTO?.hitByPitch),
                                         hits: .init(value: statsDTO?.hits),
                                         homeRuns: .init(value: statsDTO?.homeRuns),
                                         intentionalWalks: .init(value: statsDTO?.intentionalWalks),
                                         leftOnBase: .init(value: statsDTO?.leftOnBase),
                                         pickOffs: .init(value: statsDTO?.pickOffs),
                                         plateAppearances: .init(value: statsDTO?.plateAppearances),
                                         rbi: .init(value: statsDTO?.rbi),
                                         runs: .init(value: statsDTO?.runs),
                                         sacBunts: .init(value: statsDTO?.sacBunts),
                                         sacFlies: .init(value: statsDTO?.sacFlies),
                                         stolenBases: .init(value: statsDTO?.stolenBases),
                                         strikeOuts: .init(value: statsDTO?.strikeOuts),
                                         totalBases: .init(value: statsDTO?.totalBases),
                                         triples: .init(value: statsDTO?.triples),
                                         atBatsPerHomeRun: .init(value: statsDTO?.atBatsPerHomeRun),
                                         avg: .init(value: statsDTO?.avg),
                                         babip: .init(value: statsDTO?.babip),
                                         obp: .init(value: statsDTO?.obp),
                                         ops: .init(value: statsDTO?.ops),
                                         slg: .init(value: statsDTO?.slg),
                                         stolenBasePercentage: .init(value: statsDTO?.stolenBasePercentage))
    }
    
    private func formatFieldingStats(from statsDTO: MLBStatistics.Fielding.SeasonStatistics?) -> Statistics.Fielding.Season {
        return Statistics.Fielding.Season(gamesStarted: .init(value: nil),
                                          caughtStealing: .init(value: statsDTO?.caughtStealing),
                                          stolenBases: .init(value: statsDTO?.stolenBases),
                                          stolenBasePercentage: .init(value: statsDTO?.stolenBasePercentage),
                                          assists: .init(value: statsDTO?.assists),
                                          putOuts: .init(value: statsDTO?.putOuts),
                                          errors: .init(value: statsDTO?.errors),
                                          chances: .init(value: statsDTO?.chances),
                                          fielding: .init(value: statsDTO?.fielding),
                                          passedBall: .init(value: statsDTO?.passedBall),
                                          pickoffs: .init(value: statsDTO?.pickoffs))
    }
    
    private func formatPitchingStats(from statsDTO: MLBStatistics.Pitching.SeasonStatistics?) -> Statistics.Pitching.Season {
        return Statistics.Pitching.Season(gamesPlayed: .init(value: statsDTO?.gamesPlayed),
                                          gamesStarted: .init(value: statsDTO?.gamesStarted),
                                          flyOuts: .init(value: statsDTO?.flyOuts),
                                          groundOuts: .init(value: statsDTO?.groundOuts),
                                          airOuts: .init(value: statsDTO?.airOuts),
                                          runs: .init(value: statsDTO?.runs),
                                          doubles: .init(value: statsDTO?.doubles),
                                          triples: .init(value: statsDTO?.triples),
                                          homeRuns: .init(value: statsDTO?.homeRuns),
                                          strikeOuts: .init(value: statsDTO?.strikeOuts),
                                          baseOnBalls: .init(value: statsDTO?.baseOnBalls),
                                          intentionalWalks: .init(value: statsDTO?.intentionalWalks),
                                          hits: .init(value: statsDTO?.hits),
                                          hitByPitch: .init(value: statsDTO?.hitByPitch),
                                          atBats: .init(value: statsDTO?.atBats),
                                          obp: .init(value: statsDTO?.obp),
                                          caughtStealing: .init(value: statsDTO?.caughtStealing),
                                          stolenBases: .init(value: statsDTO?.stolenBases),
                                          stolenBasePercentage: .init(value: statsDTO?.stolenBasePercentage),
                                          numberOfPitches: .init(value: statsDTO?.numberOfPitches),
                                          era: .init(value: statsDTO?.era),
                                          inningsPitched: .init(value: statsDTO?.inningsPitched),
                                          wins: .init(value: statsDTO?.wins),
                                          losses: .init(value: statsDTO?.losses),
                                          saves: .init(value: statsDTO?.saves),
                                          saveOpportunities: .init(value: statsDTO?.saveOpportunities),
                                          holds: .init(value: statsDTO?.holds),
                                          blownSaves: .init(value: statsDTO?.blownSaves),
                                          earnedRuns: .init(value: statsDTO?.earnedRuns),
                                          whip: .init(value: statsDTO?.whip),
                                          battersFaced: .init(value: statsDTO?.battersFaced),
                                          outs: .init(value: statsDTO?.outs),
                                          gamesPitched: .init(value: statsDTO?.gamesPitched),
                                          completeGames: .init(value: statsDTO?.completeGames),
                                          shutouts: .init(value: statsDTO?.shutouts),
                                          pitchesThrown: .init(value: statsDTO?.pitchesThrown),
                                          balls: .init(value: statsDTO?.balls),
                                          strikes: .init(value: statsDTO?.strikes),
                                          strikePercentage: .init(value: statsDTO?.strikePercentage),
                                          hitBatsmen: .init(value: statsDTO?.hitBatsmen),
                                          balks: .init(value: statsDTO?.balks),
                                          wildPitches: .init(value: statsDTO?.wildPitches),
                                          pickoffs: .init(value: statsDTO?.pickoffs),
                                          groundOutsToAirouts: .init(value: statsDTO?.groundOutsToAirouts),
                                          rbi: .init(value: statsDTO?.rbi),
                                          winPercentage: .init(value: statsDTO?.winPercentage),
                                          pitchesPerInning: .init(value: statsDTO?.pitchesPerInning),
                                          gamesFinished: .init(value: statsDTO?.gamesFinished),
                                          strikeoutWalkRatio: .init(value: statsDTO?.strikeoutWalkRatio),
                                          strikeoutsPer9Inn: .init(value: statsDTO?.strikeoutsPer9Inn),
                                          walksPer9Inn: .init(value: statsDTO?.walksPer9Inn),
                                          hitsPer9Inn: .init(value: statsDTO?.hitsPer9Inn),
                                          runsScoredPer9: .init(value: statsDTO?.runsScoredPer9),
                                          homeRunsPer9: .init(value: statsDTO?.homeRunsPer9),
                                          inheritedRunners: .init(value: statsDTO?.inheritedRunners),
                                          inheritedRunnersScored: .init(value: statsDTO?.inheritedRunnersScored),
                                          catchersInterference: .init(value: statsDTO?.catchersInterference),
                                          sacBunts: .init(value: statsDTO?.sacBunts),
                                          sacFlies: .init(value: statsDTO?.sacFlies),
                                          passedBall: .init(value: statsDTO?.passedBall))
    }
    
    
    
    private func formatPlayers(from playerDictDTO: [String: MLBBoxscore_V2.Player]?) -> [String: Boxscore_V2.Player] {
        guard let dict = playerDictDTO else {
            return [:]
        }
        return dict.mapValues { playerDTO in
            return Boxscore_V2.Player(id: playerDTO.person.id,
                                      fullName: playerDTO.person.fullName,
                                      jerseyNumber: playerDTO.jerseyNumber ?? "",
                                      battingOrder: Int(playerDTO.battingOrder ?? "") ?? nil,
                                      position: .init(code: playerDTO.position.code, type: playerDTO.position.type, name: playerDTO.position.name, abbreviation: playerDTO.position.abbreviation),
                                      stats: formatStats(from: playerDTO.stats),
                                      seasonStats: formatStats(from: playerDTO.seasonStats))
        }
    }
    
    private func formatInfo(from infoDTO: [MLBBoxscore_V2.Info]?) -> Boxscore_V2.Info {
        
        var battingInfo: [Boxscore_V2.ListItem] = []
        var fieldingInfo: [Boxscore_V2.ListItem] = []
        var baserunningInfo: [Boxscore_V2.ListItem] = []
        
        guard let infoDTO = infoDTO else {
            return Boxscore_V2.Info(batting: battingInfo,
                                    fielding: fieldingInfo,
                                    baserunning: baserunningInfo)
        }
        
        for info in infoDTO {
            switch info.title {
            case "BATTING":
                if let list = info.fieldList {
                    battingInfo = list.map { item in
                        return Boxscore_V2.ListItem(value: item.value, label: item.label)
                    }
                }
            case "FIELDING":
                if let list = info.fieldList {
                    fieldingInfo = list.map { item in
                        return Boxscore_V2.ListItem(value: item.value, label: item.label)
                    }
                }
            case "BASERUNNING":
                if let list = info.fieldList {
                    baserunningInfo = list.map { item in
                        return Boxscore_V2.ListItem(value: item.value, label: item.label)
                    }
                }
            default:
                break
            }
        }
        
        return Boxscore_V2.Info(batting: battingInfo,
                                fielding: fieldingInfo,
                                baserunning: baserunningInfo)
    }
    
    private func formatNotes(from notesDTO: [MLBBoxscore_V2.ListItem]?) -> [Boxscore_V2.ListItem] {
        guard let notesDTO = notesDTO else {
            return []
        }
        
        return notesDTO.map({
            Boxscore_V2.ListItem(value: $0.value, label: $0.label)
        })
    }
}
