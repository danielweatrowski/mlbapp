//
//  Seeds+Game.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import Foundation

extension Seeds {

    struct Teams {
        static let phillies = Team(id: 142, name: "Philadelphia Phillies", abbreviation: "PHI", teamName: "Phillies", locationName: "Philadelphia", venue: Venues.citizensBank, division: Divisions.nationalLeagueEast, league: Leagues.nationalLeague, record: Team.SeasonRecord(gamesPlayed: 24, wins: 13, losses: 11, ties: 0, winningPercentage: "0.542"))
        
        static let mets = Team(id: 121, name: "New York Mets", abbreviation: "NYM", teamName: "Mets", locationName: "New York", venue: Venues.citiField, division: Divisions.nationalLeagueEast, league: Leagues.nationalLeague, record: Team.SeasonRecord(gamesPlayed: 24, wins: 13, losses: 11, ties: 0, winningPercentage: "0.542"))
    }
    
    struct Games {
        static let PHI_NYM_20190424 = Game(id: 565997, date: Date(), homeTeam: Teams.mets, homeTeamScore: 0, awayTeam: Teams.phillies, awayTeamScore: 6, venue: Venues.citiField, players: [:], status: .final, decisions: nil, probablePitchers: nil, linescore: nil, boxscore: nil, liveInfo: nil)
    }
    
    struct Venues {
        static let citizensBank = Venue(id: 2681, name: "Citizens Bank Park")
        static let citiField = Venue(id: 3289, name: "Citi Field")
    }
    
    struct Divisions {
        static let nationalLeagueEast = Division(id: 204, name: "National League East")
    }
    
    struct Leagues {
        static let nationalLeague = League(id: 104, name: "National League")
    }
}
