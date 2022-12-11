//
//  MLBService.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/9/22.
//

import Foundation

enum MLBRequest: HTTPRequestProtocol {

    case scoringPlays(_ gameID: Int)
    case players(_ season: String)
    case person(_ personID: Int)
    case headshot(_ personID: Int)

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
        case let .scoringPlays(gameID):
            return "/api/\(apiVersion)/game/\(gameID)/feed/live"
        case .players(_):
            return "/api/\(apiVersion)/sports/1/players"
        case let .person(personID):
            return "api/v1/people/\(personID)"
        case let .headshot(personID):
            return "/mlb-photos/image/upload/d_people:generic:headshot:67:current.png/w_213,q_auto:best/v1/people/\(personID)/headshot/67/current"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .scoringPlays(_):
            return [
                URLQueryItem(name: "fields", value: "gamePk,link,gameData,game,pk,teams,away,id,name,teamCode,fileCode,abbreviation,teamName,locationName,shortName,home,liveData,plays,allPlays,scoringPlays,scoringPlays,atBatIndex,result,description,awayScore,homeScore,about,halfInning,inning,endTime")
            ]
            //return "fields=gamePk,link,gameData,game,pk,teams,away,id,name,teamCode,fileCode,abbreviation,teamName,locationName,shortName,home,liveData,plays,allPlays,scoringPlays,scoringPlays,atBatIndex,result,description,awayScore,homeScore,about,halfInning,inning,endTime"
        case let .players(season):
            return [
                URLQueryItem(name: "season", value: season),
                URLQueryItem(name: "fields", value: "people,id,fullName,firstName,lastName,primaryNumber,currentTeam,id,primaryPosition,code,abbreviation,useName,boxscoreName,nickName,mlbDebutDate,nameFirstLast,firstLastName,lastFirstName,lastInitName,initLastName,fullFMLName,fullLFMName")
            ]
            //return "fields=people,id,fullName,firstName,lastName,primaryNumber,currentTeam,id,primaryPosition,code,abbreviation,useName,boxscoreName,nickName,mlbDebutDate,nameFirstLast,firstLastName,lastFirstName,lastInitName,initLastName,fullFMLName,fullLFMName"
        case .person(_), .headshot(_):
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
    
    var apiVersion: String {
        return "v1.1"
    }
}
