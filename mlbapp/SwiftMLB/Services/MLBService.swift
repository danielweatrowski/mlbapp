//
//  MLBService.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/9/22.
//

import Foundation


struct MLBService {
        
    var networkService: HTTPClient
    
    init(networkService: HTTPClient = HTTPClientService()) {
        self.networkService = networkService
    }
    
    func load(request: MLBRequest) {
        
    }
}

enum MLBRequest: HTTPRequestProtocol {

    case scoringPlays(_ gameID: Int)

    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "statsapi.mlb.com"
    }
    
    var path: String {
        switch self {
        case let .scoringPlays(gameID):
            return "/api/\(apiVersion)/game/\(gameID)/feed/live"
        }
    }
    
    var query: String? {
        switch self {
        case .scoringPlays(_):
            return "fields=gamePk,link,gameData,game,pk,teams,away,id,name,teamCode,fileCode,abbreviation,teamName,locationName,shortName,home,liveData,plays,allPlays,scoringPlays,scoringPlays,atBatIndex,result,description,awayScore,homeScore,about,halfInning,inning,endTime"

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
