//
//  MLBAPIService.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

struct MLBAPIService: GameStoreProtocol {
    func fetchGame(withID id: Int) async throws -> Game {
        let gameDTO = try await SwiftMLB.game(gameIdentifier: id)
        
        let gameVenue = Venue(id: gameDTO.venue.id, name: gameDTO.venue.name)
        
        let homeTeam = Team(id: gameDTO.teams.home.id,
                              name: gameDTO.teams.home.name,
                              abbreviation: gameDTO.teams.home.abbreviation,
                              teamName: gameDTO.teams.home.teamName,
                              locationName: gameDTO.teams.home.locationName,
                              venue: Venue(id: gameDTO.teams.home.venue.id, name: gameDTO.teams.home.venue.name),
                              division: Division(id: gameDTO.teams.home.division.id, name: gameDTO.teams.home.division.name),
                              league: League(id: gameDTO.teams.home.league.id, name: gameDTO.teams.home.league.name),
                              record: Team.SeasonRecord(gamesPlayed: gameDTO.teams.home.record?.gamesPlayed ?? 0,
                                                          wins: gameDTO.teams.home.record?.wins ?? 0,
                                                          losses: gameDTO.teams.home.record?.losses ?? 0,
                                                          ties: 0,
                                                          winningPercentage: gameDTO.teams.home.record?.winningPercentage ?? "NA"))
        
        let awayTeam = Team(id: gameDTO.teams.away.id,
                              name: gameDTO.teams.away.name,
                              abbreviation: gameDTO.teams.away.abbreviation,
                              teamName: gameDTO.teams.away.teamName,
                              locationName: gameDTO.teams.away.locationName,
                              venue: Venue(id: gameDTO.teams.away.venue.id, name: gameDTO.teams.away.venue.name),
                              division: Division(id: gameDTO.teams.away.division.id, name: gameDTO.teams.away.division.name),
                              league: League(id: gameDTO.teams.away.league.id, name: gameDTO.teams.away.league.name),
                              record: Team.SeasonRecord(gamesPlayed: gameDTO.teams.away.record?.gamesPlayed ?? 0,
                                                          wins: gameDTO.teams.away.record?.wins ?? 0,
                                                          losses: gameDTO.teams.away.record?.losses ?? 0,
                                                          ties: 0,
                                                          winningPercentage: gameDTO.teams.away.record?.winningPercentage ?? "NA"))
        
        let homeLineItems = gameDTO.linescore.innings.map({
            Linescore.LineItem(runs: $0.home.runs ?? -1, hits: $0.home.hits ?? -1, errors: $0.home.hits ?? -1)
        })
        let awayLineItems = gameDTO.linescore.innings.map({
            Linescore.LineItem(runs: $0.away.runs ?? -1, hits: $0.away.hits ?? -1, errors: $0.away.errors ?? -1)
        })
        
        let innings: [Linescore.Inning] = gameDTO.linescore.innings.map { inningDTO in
            
            let homeItem = Linescore.LineItem(runs: inningDTO.home.runs ?? -1,
                                              hits: inningDTO.home.hits ?? -1,
                                              errors: inningDTO.home.hits ?? -1)
            
            let awayItem = Linescore.LineItem(runs: inningDTO.away.runs ?? -1,
                                              hits: inningDTO.away.hits ?? -1,
                                              errors: inningDTO.away.hits ?? -1)
            
            return Linescore.Inning(home: homeItem,
                                    away: awayItem,
                                    num: inningDTO.num)
        }
        
        let homeTotal = Linescore.LineItem(runs: gameDTO.linescore.homeTotal.runs ?? -1,
                                           hits: gameDTO.linescore.homeTotal.hits ?? -1,
                                           errors: gameDTO.linescore.homeTotal.errors ?? -1)
        
        let awayTotal = Linescore.LineItem(runs: gameDTO.linescore.awayTotal.runs ?? -1,
                                           hits: gameDTO.linescore.awayTotal.hits ?? -1,
                                           errors: gameDTO.linescore.awayTotal.errors ?? -1)
        
        let linescore = Linescore(innings: innings, homeTotal: homeTotal, awayTotal: awayTotal)
        
        let game = Game(id: id,
                        date: gameDTO.gameDate,
                        homeTeam: homeTeam,
                        homeTeamScore: gameDTO.linescore.homeTotal.runs ?? 0,
                        awayTeam: awayTeam,
                        awayTeamScore: gameDTO.linescore.awayTotal.runs ?? 0,
                        venue: gameVenue,
                        linescore: linescore)
        
        return game
    }
}
