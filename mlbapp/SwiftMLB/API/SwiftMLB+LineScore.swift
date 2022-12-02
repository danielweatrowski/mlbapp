//
//  SwiftMLB+LineScore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/13/22.
//

import Foundation
import Combine

public extension SwiftMLB {
    
//    static func lineScore(withGameIdentifer gameIdentifier: Int) -> AnyPublisher<LineScoreResponse, Error> {
//        let url = URL(string: "https://statsapi.mlb.com/api/v1.1/game/\(gameIdentifier)/feed/live"
//                      + "?fields=gameData,teams,teamName,shortName,status,abstractGameState,liveData,linescore,innings,num,home,away,runs,hits,errors")!
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: LineScoreResponse.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//}
 
// https://statsapi.mlb.com/api/v1.1/game/565997/feed/live?fields=gameData,game,teams,teamName,shortName,teamStats,batting,atBats,runs,hits,doubles,triples,homeRuns,rbi,stolenBases,strikeOuts,baseOnBalls,leftOnBase,pitching,inningsPitched,earnedRuns,homeRuns,players,boxscoreName,liveData,boxscore,teams,players,id,fullName,allPositions,abbreviation,seasonStats,batting,avg,ops,obp,slg,era,pitchesThrown,numberOfPitches,strikes,battingOrder,info,title,fieldList,note,label,value,wins,losses,holds,blownSaves

}
