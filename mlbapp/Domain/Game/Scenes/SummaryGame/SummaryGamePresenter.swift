//
//  SummaryGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/12/23.
//

import Foundation

protocol SummaryGamePresentationLogic: SceneErrorPresentable {
    func presentPlaysList(output: SummaryGame.Output)
    func presentSceneError(_ sceneError: SceneError)
}

struct SummaryGamePresenter: SummaryGamePresentationLogic {
    
    typealias PlaysPerInning = [Int: [SummaryGame.InningPlayViewModel]]
        
    let viewModel: SummaryGame.ViewModel
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
    
    func presentPlaysList(output: SummaryGame.Output) {
        
        // Create two dicts that map inning number to the plays that occured in that inning
        var homeInningPlays: [Int: [SummaryGame.InningPlayViewModel]] = [:]
        var awayInningPlays:  [Int: [SummaryGame.InningPlayViewModel]] = [:]
        
        for play in output.plays {
            
            let inningHashID = play.about.inning
            let timeFormatted = play.about.endTime.formatted(date: .omitted, time: .shortened)
            
            let playViewModel = SummaryGame.InningPlayViewModel(playID: play.about.atBatIndex,
                                                                eventName: play.result.event,
                                                                description: play.result.description,
                                                                time: timeFormatted,
                                                                numberOfOuts: nil)
            if play.isAwayTeam {
                if awayInningPlays[inningHashID] != nil {
                    awayInningPlays[inningHashID]?.append(playViewModel)
                } else {
                    awayInningPlays[inningHashID] = []
                    awayInningPlays[inningHashID]?.append(playViewModel)
                }
            } else if play.isHomeTeam {
                if homeInningPlays[inningHashID] != nil {
                    homeInningPlays[inningHashID]?.append(playViewModel)
                } else {
                    homeInningPlays[inningHashID] = []
                    homeInningPlays[inningHashID]?.append(playViewModel)
                }
            }
        }
        
        let sectionsViewModel = formatInningSections(homeInningPlays: homeInningPlays,
                                                     awayInningPlays: awayInningPlays,
                                                     innings: output.totalInningsPlayed)
        
        DispatchQueue.main.async {
            viewModel.sections = sectionsViewModel
            viewModel.state = .loaded
        }
    }
    
    private func formatInningSections(homeInningPlays: PlaysPerInning, awayInningPlays: PlaysPerInning, innings: Int) -> [SummaryGame.InningSectionViewModel] {
        
        var sectionsViewModel: [SummaryGame.InningSectionViewModel] = []
        for i in 1..<innings + 1 {
            
            let topInningPlays = awayInningPlays[i] ?? []
            if !topInningPlays.isEmpty {
                
                let topSectionViewModel = SummaryGame.InningSectionViewModel(inningNumber: i,
                                                                             inningName: "Top \(i)",
                                                                             plays: topInningPlays)
                sectionsViewModel.append(topSectionViewModel)
            }
            
            let botInningPlays = homeInningPlays[i] ?? []
            if !botInningPlays.isEmpty {
                let botSectionViewModel = SummaryGame.InningSectionViewModel(inningNumber: i,
                                                                             inningName: "Bottom \(i)",
                                                                             plays: botInningPlays)
                
                sectionsViewModel.append(botSectionViewModel)
            }
        }
        
        return sectionsViewModel
    }
}
