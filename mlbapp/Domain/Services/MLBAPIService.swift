//
//  MLBAPIService.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

struct MLBAPIService: GameStoreProtocol {
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result] {
        
        let searchParameters = SwiftMLBRequest.ScheduleParameters(startDate: parameters.startDate,
                                                                  endDate: parameters.endDate,
                                                                  teamIdentifier: String(parameters.homeTeamID),
                                                                  opponentIdentifier: parameters.awayTeamID == 0 ? nil : String(parameters.awayTeamID!)
        )
        
        let schedule = try await SwiftMLB.schedule(parameters: searchParameters)
        
        let games = schedule.games.map({
            GameSearch.Result(id: $0.gamePk,
                              gameDate: $0.gameDate,
                              venueName: $0.venue.name,
                              awayTeam: GameSearch.Result.Team(id: $0.teams.away.team.id,
                                                               name: $0.teams.away.team.name,
                                                               score: $0.teams.away.score ?? -1,
                                                               wins: $0.teams.away.leagueRecord.wins,
                                                               losses: $0.teams.away.leagueRecord.losses),
                              homeTeam: GameSearch.Result.Team(id: $0.teams.home.team.id,
                                                               name: $0.teams.home.team.name,
                                                               score: $0.teams.home.score ?? -1 ,
                                                               wins: $0.teams.home.leagueRecord.wins,
                                                               losses: $0.teams.home.leagueRecord.losses))
        })
        
        return games
    }
    
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
        
        let players = gameDTO.players.map({
            Player(id: $0.id,
                   firstName: $0.firstName,
                   lastName: $0.lastName,
                   fullName: $0.fullName,
                   birthCity: $0.birthCity,
                   birthCountry: $0.birthCountry,
                   lastInitName: $0.lastInitName,
                   boxscoreName: $0.boxscoreName,
                   height: $0.height,
                   weight: $0.weight,
                   currentAge: $0.currentAge,
                   birthDate: $0.birthDate,
                   isActive: $0.active,
                   mlbDebutDate: $0.mlbDebutDate,
                   primaryPositionCode: $0.primaryPosition.code)
        })
        

        let linescore = LinescoreAdapter(dataObject: gameDTO.linescore).toDomain()
        let boxscore = BoxscoreAdapter(dataObject: gameDTO.boxscore).toDomain()
        
        let game = Game(id: id,
                        date: gameDTO.gameDate,
                        homeTeam: homeTeam,
                        homeTeamScore: gameDTO.linescore.homeTotal.runs ?? 0,
                        awayTeam: awayTeam,
                        awayTeamScore: gameDTO.linescore.awayTotal.runs ?? 0,
                        venue: gameVenue,
                        players: players,
                        winningPitcherID: gameDTO.decisions.winner.id,
                        losingPitcherID: gameDTO.decisions.loser.id,
                        linescore: linescore,
                        boxscore: boxscore)
        
        return game
    }
}
