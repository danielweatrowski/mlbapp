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
        case .players(_):
            return "/api/v1.1/sports/1/players"
        case let .player(parameters):
            return "/api/v1/people/\(parameters.personIdentifier)"
        case let .headshot(personID):
            return "/mlb-photos/image/upload/d_people:generic:headshot:67:current.png/w_213,q_auto:best/v1/people/\(personID)/headshot/67/current"
        case let .boxscore(gameID):
            return "/api/v1.1/game/\(gameID)/feed/live"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .scoringPlays:
            return [
                URLQueryItem(name: "fields",
                             value: "gamePk,link,gameData,game,pk,teams,away,id,name,teamCode,fileCode,abbreviation,teamName,locationName,shortName,home,liveData,plays,allPlays,scoringPlays,scoringPlays,atBatIndex,result,description,awayScore,homeScore,about,halfInning,inning,endTime")
            ]
        case let .players(season):
            return [
                URLQueryItem(name: "season",
                             value: season),
                URLQueryItem(name: "fields",
                             value: "people,id,fullName,firstName,lastName,primaryNumber,currentTeam,id,primaryPosition,code,abbreviation,useName,boxscoreName,nickName,mlbDebutDate,nameFirstLast,firstLastName,lastFirstName,lastInitName,initLastName,fullFMLName,fullLFMName")
            ]
        case let .schedule(parameters):
            return [
                URLQueryItem(name: "startDate", value: parameters.startDate?.formatted(date: .numeric, time: .omitted)),
                URLQueryItem(name: "endDate", value: parameters.endDate?.formatted(date: .numeric, time: .omitted)),
                URLQueryItem(name: "teamId", value: parameters.teamIdentifier),
                URLQueryItem(name: "opponentId", value: parameters.opponentIdentifier),
                URLQueryItem(name: "gameType", value: parameters.gameType),
                URLQueryItem(name: "sportId", value: "1")

            ]
        case .boxscore:
            return [
                URLQueryItem(name: "fields", value: "gameData,game,teams,teamName,shortName,teamStats,batting,atBats,runs,hits,doubles,triples,homeRuns,rbi,stolenBases,strikeOuts,baseOnBalls,leftOnBase,pitching,inningsPitched,earnedRuns,homeRuns,players,boxscoreName,liveData,boxscore,teams,players,id,fullName,allPositions,abbreviation,seasonStats,batting,avg,ops,obp,slg,era,pitchesThrown,numberOfPitches,strikes,battingOrder,info,title,fieldList,note,label,value,wins,losses,holds,blownSaves")
            ]
        case let .player(parameters):
            return parameters.toQueryItems()
        case .headshot(_):
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
