//
//  SwiftMLBRequest.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/9/22.
//

import Foundation

public enum SwiftMLBRequest: HTTPRequestProtocol {

    case scoringPlays(_ gameID: Int)
    case players(_ season: String)
    case headshot(_ personID: Int)
    case schedule(_ parameters: ScheduleParameters)
    case player(_ parameters: PersonParameters)
    case boxscore(_ gameID: Int)
    case linescore(_ gameID: Int)
    case game(_ gameID: Int)
    case plays(_ gameID: Int)
    case roster(_ paramaters: RosterParameters)
    case standings(_ parameters: StandingsParameters)
    case meta(_ type: String)
    case content(_ gameID: Int)

    var scheme: String {
        return "https"
    }
    
    var host: String {
        switch self {
        case .headshot(_):
            return "img.mlbstatic.com"
        default:
            return "statsapi.mlb.com"
        }
    }
    
    var path: String {
        switch self {
        case .schedule(_):
            return "/api/v1/schedule"
        case let .scoringPlays(gameID):
            return "/api/v1.1/game/\(gameID)/feed/live"
        case let .plays(gameID):
            return "/api/v1/game/\(gameID)/playByPlay"
        case .players(_):
            return "/api/v1.1/sports/1/players"
        case let .player(parameters):
            return "/api/v1/people/\(parameters.personIdentifier)"
        case let .headshot(personID):
            return "/mlb-photos/image/upload/d_people:generic:headshot:67:current.png/w_213,q_auto:best/v1/people/\(personID)/headshot/67/current"
        case let .boxscore(gameID):
            return "/api/v1/game/\(gameID)/boxscore"
        case let .linescore(gameID):
            return "/api/v1.1/game/\(gameID)/feed/live"
        case let .game(gameID):
            return "/api/v1.1/game/\(gameID)/feed/live"
        case let .roster(parameters):
            return "/api/v1/teams/\(parameters.teamIdentifier)/roster"
        case .standings:
            return "/api/v1/standings"
        case let .meta(type):
            return "/api/v1/\(type)"
        case let .content(gameID):
            return "/api/v1/game/\(gameID)/content"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .scoringPlays:
            return [
                URLQueryItem(name: "fields",
                             value: "gamePk,link,gameData,game,pk,teams,away,id,name,teamCode,fileCode,abbreviation,teamName,locationName,shortName,home,liveData,plays,allPlays,scoringPlays,scoringPlays,atBatIndex,result,type,event,eventType,description,awayScore,homeScore,rbi,isOut,about,halfInning,inning,endTime,startTime,hasOut")
            ]
        case let .players(season):
            return [
                URLQueryItem(name: "season",
                             value: season),
                URLQueryItem(name: "fields",
                             value: "people,id,fullName,firstName,lastName,primaryNumber,currentTeam,id,primaryPosition,code,abbreviation,useName,boxscoreName,nickName,mlbDebutDate,nameFirstLast,firstLastName,lastFirstName,lastInitName,initLastName,fullFMLName,fullLFMName")
            ]
        case let .schedule(parameters):
            return parameters.toQueryItems()
        case .linescore:
            return [
                URLQueryItem(name: "fields", value: "gameData,teams,teamName,shortName,status,abstractGameState,liveData,linescore,innings,num,home,away,runs,hits,errors,decisions,winner,loser,id,fullName")
            ]
        case let .player(parameters):
            return parameters.toQueryItems()
        case let .roster(parameters):
            return parameters.toQueryItems()
        case let .standings(parameters):
            return parameters.toQueryParameters()
        case .headshot, .game, .meta, .plays, .content, .boxscore:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
}