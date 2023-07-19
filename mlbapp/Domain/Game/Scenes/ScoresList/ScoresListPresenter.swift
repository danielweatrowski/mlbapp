//
//  ScoresListPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import Foundation

protocol ScoresListPresentationLogic: SceneErrorPresentable {
    func presentScoresList(output: ScoresList.Output)
}

struct ScoresListPresenter: ScoresListPresentationLogic {
    
    let viewModel: ScoresList.ViewModel
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
    
    func presentScoresList(output: ScoresList.Output) {
        
        let gridItems = output.results.map { result in
            
            let bannerViewModel = formatBanner(gameResult: result, includeVenue: false)
            
            return ScoresListItemViewModel(gameID: result.id,
                                           homeTeamName: result.homeTeam.teamName,
                                           homeTeamRecord: result.homeTeam.record,
                                           homeTeamAbbreviation: result.homeTeam.abbreviation,
                                           homeTeamScore: result.homeTeam.score,
                                           awayTeamName: result.awayTeam.teamName,
                                           awayTeamRecord: result.awayTeam.record,
                                           awayTeamAbbreviation: result.awayTeam.abbreviation,
                                           awayTeamScore: result.awayTeam.score,
                                           bannerViewModel: bannerViewModel)
            
            
        }
        
        DispatchQueue.main.async {
            viewModel.listItems = gridItems
            viewModel.state = .loaded
        }
    }
    
    private func formatLineScore(gameResult: GameSearch.Result, homeAbbreviation: String, awayAbbrevation: String) -> LinescoreGridViewModel? {
        
        guard let linescore = gameResult.linescore else {
            return nil
        }
        
        return LinescoreGridViewModel(homeAbbreviation: homeAbbreviation,
                                      awayAbbreviation: awayAbbrevation,
                                      linescore)
    }
    
    private func formatBanner(gameResult: GameSearch.Result, includeVenue: Bool = true) -> StatusBannerViewModel {
        let venueName = includeVenue ? gameResult.venueName : ""
        switch gameResult.status {
        case .live:
            
            var currentInningText: String?
            if let liveInfo = gameResult.liveInfo {
                currentInningText = "\(liveInfo.inningState) \(liveInfo.currentInningDescription)"
            }
            
            return StatusBannerViewModel(statusText: currentInningText ?? "LIVE", secondaryStatusText: venueName, backgroundColor: .green)
        case .final:
            return StatusBannerViewModel(statusText: "FINAL", statusTextColor: .red, secondaryStatusText: venueName, secondaryStatusTextColor: .secondary, backgroundColor: .clear, divider: true)
        default:
            let text = gameResult.gameDate.formatted(date: .omitted, time: .shortened)
            return StatusBannerViewModel(statusText: text, statusTextColor: .secondary, secondaryStatusText: venueName, secondaryStatusTextColor: .secondary, backgroundColor: .clear, divider: true)
        }
    }

}
