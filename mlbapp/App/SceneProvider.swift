//
//  SceneProvider.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 8/14/23.
//

import SwiftUI
import Standings
import Common
import Views

@MainActor
extension View {
    func withSceneProvider() -> some View {
        navigationDestination(for: AppScene.self) { destination in
            switch destination {
            case let .gameDetail(id):
                DetailGameConfigurator.configure(for: id)
            case let .boxscore(id, date, homeAbbr, awayAbbr, boxscore, players):
                BoxscoreDetailView.configure(gameID: id, formattedGameDate: date, homeTeamAbbreviation: homeAbbr, awayTeamAbbreviation: awayAbbr, boxscore: boxscore, players: players)
            case let .summaryGame(gameID: gameID, homeTeamName: homeTeamName, awayTeamName: awayTeamName):
                PlaysListView.configure(gameID: gameID, homeTeamName: homeTeamName, awayTeamName: awayTeamName)
            case let .lineupDetail(gameID: gameID, boxscore: boxscore):
                LineupDetailView.configure(gameID: gameID, boxscore: boxscore)
            case let .rosterDetail(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: gameDate):
                RosterDetailView.configure(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: gameDate)
            case let .videosList(gameID):
                VideosListView.configure(gameID: gameID)
            case let .teamStandingDetail(standing):
                StandingsDetailView.configure(standing: standing)
            case .empty:
                EmptyView()
            case .videoPlayer(let url):
                VideoPlayerView(videoURL: url)
            }
        }
    }
}

@MainActor
extension View {
    func withSceneSheetProvider(sheetItem: Binding<AppScene?>) -> some View {
        sheet(item: sheetItem) { sheet in
            switch sheet {
            case .videoPlayer(let url):
                VideoPlayerView(videoURL: url)
            default: EmptyView()
            }
        }
    }
}
