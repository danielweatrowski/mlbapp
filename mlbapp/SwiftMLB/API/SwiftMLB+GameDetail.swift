//
//  SwiftMLB+GameData.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

extension SwiftMLB {
    
    private static let gameScoreParameters = "?fields=gameData,game,teams,teamName,shortName,teamStats,batting,atBats,runs,hits,doubles,triples,homeRuns,rbi,stolenBases,strikeOuts,baseOnBalls,leftOnBase,pitching,inningsPitched,earnedRuns,homeRuns,players,boxscoreName,liveData,boxscore,teams,players,id,fullName,allPositions,abbreviation,seasonStats,batting,avg,ops,obp,slg,era,pitchesThrown,numberOfPitches,strikes,battingOrder,info,title,fieldList,note,label,value,wins,losses,holds,blownSaves,linescore,innings,num,home,away,runs,hits,errors"
    
    
    static func gameDetail(forGameIdentifier gameID: Int) async throws -> LineScore {
        let urlString = "https://statsapi.mlb.com/api/v1.1/game/\(gameID)/feed/live" + gameScoreParameters
        
        guard let url = URL(string: urlString) else {

            throw SwiftMLBError.invalidURL(urlString: urlString)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // parse the data
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        guard let liveData = dict["liveData"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "liveData")
        }
        guard let linescore = liveData["linescore"] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: "linescore")
        }
    
        return try LineScore(dictionary: linescore)
    }
}
