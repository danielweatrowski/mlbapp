//
//  DetailGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation

protocol DetailGamePresentationLogic {
    func presentGame(response: DetailGame.DetailGame.Response)
}

class DetailGamePresenter: DetailGamePresentationLogic {
    var view: DetailGameDisplayLogic?
    
    @MainActor
    func presentGame(response: DetailGame.DetailGame.Response) {
        let game = response.game
        
        let headerViewModel = DetailGame.DetailGame.ViewModel.DetailGameHeader(homeTeam: game.homeTeam,
                                                          homeTeamScore: String(game.homeTeamScore),
                                                          homeTeamRecord: "\(game.homeTeamWins)-\(game.homeTeamLosses)",
                                                          awayTeam: game.awayTeam,
                                                          awayTeamScore: String(game.awayTeamScore),
                                                          awayTeamRecord: "\(game.awayTeamWins)-\(game.awayTeamLosses)")
        
        let infoViewModel = DetailGame.DetailGame.ViewModel.InfoViewModel(gameDate: game.date.formatted(),
                                                                          venueName: game.venue.name)
        
        let lineScoreViewModel = formatLineScore(linescore: response.linescore,
                                                 homeTeam: game.homeTeam,
                                                 awayTeam: game.awayTeam)
        
        let viewModel = DetailGame.DetailGame.ViewModel(headerViewModel: headerViewModel,
                                                        infoViewModel: infoViewModel,
                                                        lineScoreViewModel: lineScoreViewModel)
        view?.displayGame(viewModel: viewModel)
    }
    
    private func formatLineScore(linescore: MLBLinescore, homeTeam: Team, awayTeam: Team) -> LineScoreViewModel {
        
        var spacer: LineScoreViewItem {
            LineScoreViewItem(id: UUID(), type: .none, value: "")
        }
        
        var awayLineItems = [LineScoreViewItem]()
        var homeLineItems = [LineScoreViewItem]()
        var headerLineItems = [LineScoreViewItem]()
    
        let a_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: awayTeam.abbreviation)
        let h_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: homeTeam.abbreviation)
        
        // Teams
        awayLineItems.append(a_nameAbbreviation)
        homeLineItems.append(h_nameAbbreviation)
        headerLineItems.append(spacer)
                
        // Innings
        for inning in linescore.innings {
            let homeInningRuns = inning.away.runs ?? 0
            let awayInningRuns = inning.home.runs ?? 0

            let h_runItem = LineScoreViewItem(id: UUID(), type: .run, value: String(homeInningRuns))
            let a_runItem = LineScoreViewItem(id: UUID(), type: .run, value: String(awayInningRuns))
            let headerItem = LineScoreViewItem(id: UUID(), type: .header, value: String(inning.num))
            
            awayLineItems.append(a_runItem)
            homeLineItems.append(h_runItem)
            headerLineItems.append(headerItem)
        }
        
        // Spacer
        awayLineItems.append(spacer)
        homeLineItems.append(spacer)
        headerLineItems.append(spacer)
        
        // Runs
        let runsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "R")
        headerLineItems.append(runsHeaderItem)
        
        let h_runsTotal = linescore.homeTotal.runs ?? 0
        let h_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_runsTotal))
        homeLineItems.append(h_runsTotalItem)
        
        let a_runsTotal = linescore.awayTotal.runs ?? 0
        let a_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_runsTotal))
        awayLineItems.append(a_runsTotalItem)
        
        // Hits
        let hitsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "H")
        headerLineItems.append(hitsHeaderItem)
        
        let h_hitsTotal = linescore.homeTotal.hits ?? 0
        let h_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_hitsTotal))
        homeLineItems.append(h_hitsTotalItem)
        
        let a_hitsTotal = linescore.awayTotal.hits ?? 0
        let a_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_hitsTotal))
        awayLineItems.append(a_hitsTotalItem)
        
        // Errors
        let errorsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "E")
        headerLineItems.append(errorsHeaderItem)
        
        let h_errorsTotal = linescore.homeTotal.errors ?? 0
        let h_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_errorsTotal))
        homeLineItems.append(h_errorsTotalItem)
        
        let a_errorsTotal = linescore.awayTotal.errors ?? 0
        let a_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_errorsTotal))
        awayLineItems.append(a_errorsTotalItem)
        
        return LineScoreViewModel(headers: headerLineItems,
                                  homeLineItems: homeLineItems,
                                  awayLineItems: awayLineItems)
        
    }
    
}
