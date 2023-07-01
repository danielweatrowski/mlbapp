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
            viewModel.sceneError.errorTitle = sceneError.errorTitle
            viewModel.sceneError.errorDescription = sceneError.errorDescription
            
        DispatchQueue.main.async {
            self.viewModel.sceneError.present()
        }
    }
    
    func presentScoresList(output: ScoresList.Output) {
        let listGameRows = output.results.map { result in
            
            let homeTeam = ActiveTeam.team(withIdentifier: result.homeTeam.id)
            let awayTeam = ActiveTeam.team(withIdentifier: result.awayTeam.id)
            
            let homeAbbreviation = homeTeam?.abbreviation ?? "NA"
            let awayAbbreviation = awayTeam?.abbreviation ?? "NA"
            let linescoreViewModel = formatLineScore(gameResult: result,
                                            homeAbbreviation: homeAbbreviation,
                                            awayAbbrevation: awayAbbreviation)
            let bannerViewModel = formatBanner(gameResult: result)
            
            return ListGameRowViewModel(gameID: result.id,
                                        gameStatus: result.status,
                                     gameVenueName: result.venueName,
                                     homeTeamID: result.homeTeam.id,
                                     homeTeamName: result.homeTeam.name,
                                     homeTeamAbbreviation: homeAbbreviation,
                                     homeTeamScore: String(result.homeTeam.score),
                                     homeTeamRecord: result.homeTeam.record,
                                     homeTeamLogoName: "",
                                     awayTeamID: result.awayTeam.id,
                                     awayTeamName: result.awayTeam.name,
                                     awayTeamAbbreviation: awayAbbreviation,
                                     awayTeamScore: String(result.awayTeam.score),
                                     awayTeamRecord: result.awayTeam.record,
                                        awayTeamLogoName: "",
                                        winningPitcherName: result.decisions?.winner.fullName,
                                        losingPitcherName: result.decisions?.loser.fullName,
                                        savePitcherName: result.decisions?.save?.fullName,
                                        linescoreViewModel: linescoreViewModel,
                                        statusBannerViewModel: bannerViewModel)
        }
        
        DispatchQueue.main.async {
            viewModel.rows = listGameRows
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
    
    private func formatBanner(gameResult: GameSearch.Result) -> StatusBannerViewModel {
        switch gameResult.status {
        case .live:
            
            var currentInningText: String?
            if let liveInfo = gameResult.liveInfo {
                currentInningText = "\(liveInfo.currentInningHalf) \(liveInfo.currentInningDescription)"
            }
            
            return StatusBannerViewModel(statusText: currentInningText ?? "LIVE", secondaryStatusText: gameResult.venueName, backgroundColor: .green)
        case .final:
            return StatusBannerViewModel(statusText: "FINAL", statusTextColor: .red, secondaryStatusText: gameResult.venueName, secondaryStatusTextColor: .secondary, backgroundColor: .clear, divider: true)
        default:
            let text = gameResult.gameDate.formatted(date: .omitted, time: .shortened)
            return StatusBannerViewModel(statusText: text, statusTextColor: .secondary, secondaryStatusText: gameResult.venueName, secondaryStatusTextColor: .secondary, backgroundColor: .clear, divider: true)
        }
    }

}
