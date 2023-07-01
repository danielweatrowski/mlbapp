//
//  SummaryGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/12/23.
//

import Foundation

protocol SummaryGamePresentationLogic: SceneErrorPresentable {
    func presentGameSummary(output: SummaryGame.Output<Play>)
    func presentSceneError(_ sceneError: SceneError)
}

struct SummaryGamePresenter: SummaryGamePresentationLogic {
        
    let viewModel: SummaryGame.ViewModel
    
    func presentSceneError(_ sceneError: SceneError) {
        self.viewModel.sceneError.errorTitle = sceneError.errorTitle
        self.viewModel.sceneError.errorDescription = sceneError.errorDescription
        
        DispatchQueue.main.async {
            self.viewModel.sceneError.present()
        }
    }
    
    func presentGameSummary(output: SummaryGame.Output<Play>) {
        
        var homeInningPlays: [Int: [SummaryGame.InningPlayViewModel]] = [:]
        var awayInningPlays:  [Int: [SummaryGame.InningPlayViewModel]] = [:]
        
        for play in output.plays {
            let inningHashID = play.about.inning
            let timeFormatted = play.about.endTime.formatted(date: .omitted, time: .shortened)
            let playViewModel = SummaryGame.InningPlayViewModel(playID: play.about.atBatIndex,
                                                                eventName: play.result.event ?? "OH NO",
                                                                description: play.result.description,
                                                                time: timeFormatted,
                                                                numberOfOuts: nil)
            
            if play.about.halfInning == "top" {
                if awayInningPlays[inningHashID] != nil {
                    awayInningPlays[inningHashID]?.append(playViewModel)
                } else {
                    awayInningPlays[inningHashID] = []
                    awayInningPlays[inningHashID]?.append(playViewModel)
                }
            } else {
                if homeInningPlays[inningHashID] != nil {
                    homeInningPlays[inningHashID]?.append(playViewModel)
                } else {
                    homeInningPlays[inningHashID] = []
                    homeInningPlays[inningHashID]?.append(playViewModel)
                }
            }
        }
        
        var sectionsViewModel: [SummaryGame.InningSectionViewModel] = []
        for i in 1..<homeInningPlays.keys.count + 1 {
            
            let topInningPlays = awayInningPlays[i] ?? []
            let topSectionViewModel = SummaryGame.InningSectionViewModel(inningNumber: i,
                                                                      inningName: "Top \(i)",
                                                                      plays: topInningPlays)
            
            sectionsViewModel.append(topSectionViewModel)
            let botInningPlays = homeInningPlays[i] ?? []
            let botSectionViewModel = SummaryGame.InningSectionViewModel(inningNumber: i,
                                                                      inningName: "Bottom \(i)",
                                                                      plays: botInningPlays)
            
            sectionsViewModel.append(botSectionViewModel)
            
        }
        
        DispatchQueue.main.async {
            viewModel.sections = sectionsViewModel
            viewModel.state = .loaded
        }
    }

}
