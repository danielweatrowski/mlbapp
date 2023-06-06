//
//  MLBAPIService.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

struct MLBAPIRepository: GameStoreProtocol {    
    func searchGame(with parameters: GameSearch.SearchParameters) async throws -> [GameSearch.Result] {
        
        let searchParameters = SwiftMLBRequest.ScheduleParameters(startDate: parameters.startDate,
                                                                  endDate: parameters.endDate,
                                                                  teamIdentifier: parameters.homeTeamID == nil ? nil : String(parameters.homeTeamID!),
                                                                  opponentIdentifier: (parameters.awayTeamID == 0 || parameters.awayTeamID == nil) ? nil : String(parameters.awayTeamID!)
        )
        
        let schedule = try await SwiftMLB.schedule(parameters: searchParameters)
        
        let games = schedule.games.map { gameDTO in
            var linescore: Linescore?
            if let linescoreDTO = gameDTO.linescore {
                linescore = LinescoreAdapter(dataObject: linescoreDTO).toDomain()
            }
            
            let decisionsAdapter = DecisionsAdapter(dataObject: gameDTO.decisions)
            let decisions = decisionsAdapter.toDomain()
            
            let gameStatus = GameStatus(rawValue: gameDTO.status.abstractGameState) ?? .other
            
            return GameSearch.Result(id: gameDTO.gamePk,
                              gameDate: gameDTO.gameDate,
                                     venueName: gameDTO.venue.name,
                                     status: gameStatus,
                              awayTeam: GameSearch.Result.Team(id: gameDTO.teams.away.team.id,
                                                               name: gameDTO.teams.away.team.name,
                                                               score: gameDTO.teams.away.score ?? -1,
                                                               wins: gameDTO.teams.away.leagueRecord.wins,
                                                               losses: gameDTO.teams.away.leagueRecord.losses),
                              homeTeam: GameSearch.Result.Team(id: gameDTO.teams.home.team.id,
                                                               name: gameDTO.teams.home.team.name,
                                                               score: gameDTO.teams.home.score ?? -1 ,
                                                               wins: gameDTO.teams.home.leagueRecord.wins,
                                                               losses: gameDTO.teams.home.leagueRecord.losses),
                                     linescore: linescore,
                                     decisions: decisions)
        }
        
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
        
        let players = gameDTO.players.reduce(into: [Int: Player]()) {
            $0[$1.id] = Player(id: $1.id,
                               firstName: $1.firstName,
                               lastName: $1.lastName,
                               fullName: $1.fullName,
                               birthCity: $1.birthCity,
                               birthCountry: $1.birthCountry,
                               lastInitName: $1.lastInitName,
                               boxscoreName: $1.boxscoreName,
                               height: $1.height,
                               weight: $1.weight,
                               currentAge: $1.currentAge,
                               birthDate: $1.birthDate,
                               isActive: $1.active,
                               mlbDebutDate: $1.mlbDebutDate ?? "",
                               primaryPositionCode: $1.primaryPosition.code ?? "")
        }
        
        let linescoreAdapter = LinescoreAdapter(dataObject: gameDTO.linescore)
        let linescore = linescoreAdapter.toDomain()
        
        let boxscoreAdapter = BoxscoreAdapter(dataObject: gameDTO.boxscore)
        let boxscore = boxscoreAdapter.toDomain()
        
        let decisionsAdapter = DecisionsAdapter(dataObject: gameDTO.decisions)
        let decisions = decisionsAdapter.toDomain()
        
        let probablePitchersAdapter = ProbablePitchersAdapter(dataObject: gameDTO.probablePitchers)
        let probablePitchers = probablePitchersAdapter.toDomain()
        
        let gameStatus = GameStatus(rawValue: gameDTO.status.abstractGameState) ?? .other
        
        let gameInfo = Game.Info(weatherTempurature: gameDTO.weather?.temp,
                                 windDescription: gameDTO.weather?.wind,
                                 firstPitchDateString: gameDTO.gameInfo?.firstPitch,
                                 attendance: gameDTO.gameInfo?.attendance,
                                 gameDurationInMinutes: gameDTO.gameInfo?.gameDurationMinutes)
                                 
        
        let game = Game(id: id,
                        date: gameDTO.gameDate,
                        homeTeam: homeTeam,
                        homeTeamScore: gameDTO.linescore.teams.home?.runs ?? 0,
                        awayTeam: awayTeam,
                        awayTeamScore: gameDTO.linescore.teams.away?.runs ?? 0,
                        venue: gameVenue,
                        players: players,
                        info: gameInfo,
                        status: gameStatus,
                        decisions: decisions,
                        probablePitchers: probablePitchers,
                        linescore: linescore,
                        boxscore: boxscore)
        
        return game
    }
    
    func fetchBoxscore(forGameID id: Int) async throws -> Boxscore {
        let boxscoreDTO = try await SwiftMLB.boxscore(gameIdentifier: id)
        
        let boxscoreAdapter = BoxscoreAdapter(dataObject: boxscoreDTO)
        let boxscore = boxscoreAdapter.toDomain()
        
        return boxscore
    }
    
    func fetchAllPlays(forGameID id: Int) async throws -> [Play] {
        let dto = try await SwiftMLB.plays(for: id)
        
        let plays: [Play?] = dto.allPlays.map { playDTO in
            
            guard let event = playDTO.result.event, let eventType = playDTO.result.eventType, let desc = playDTO.result.description else {
                return nil
            }
            
            let result = Play.Result(type: playDTO.result.type,
                                     event: event,
                                     eventType: eventType,
                                     description: desc,
                                     rbi: playDTO.result.rbi,
                                     awayScore: playDTO.result.awayScore,
                                     homeScore: playDTO.result.homeScore,
                                     isOut: playDTO.result.isOut)
            
            let about = Play.Detail(atBatIndex: playDTO.about.atBatIndex,
                                    halfInning: playDTO.about.halfInning,
                                    inning: playDTO.about.inning,
                                    hasOut: playDTO.about.hasOut,
                                    endTime: playDTO.about.endTime)
            
            return Play(result: result, about: about)
        }
        
        return plays
            .compactMap({$0})
    }
}
