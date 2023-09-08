//
//  SummaryGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/12/23.
//

import Foundation
import Common
import Models
import Views

protocol PlaysListPresentationLogic: SceneErrorPresentable {
    func presentPlaysList(output: PlaysList.Output)
    func presentSceneError(_ sceneError: SceneError)
}

struct PlaysListPresenter: PlaysListPresentationLogic {
    
    typealias PlaysPerInning = [Int: [PlaysList.InningPlayViewModel]]
        
    let viewModel: PlaysList.ViewModel
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
    
    func presentPlaysList(output: PlaysList.Output) {
        
        // Create two dicts that map inning number to the plays that occured in that inning
        var homeInningPlays: [Int: [PlaysList.InningPlayViewModel]] = [:]
        var awayInningPlays:  [Int: [PlaysList.InningPlayViewModel]] = [:]
        
        for play in output.plays {
            
            guard let eventType = play.result.eventType, let desc = play.result.description else {
                continue
            }
            
            let inningHashID = play.about.inning
            let timeFormatted = play.about.endTime?.formatted(date: .omitted, time: .shortened)
            
            let playViewModel = PlaysList.InningPlayViewModel(playID: play.about.atBatIndex,
                                                                eventName: eventType,
                                                                description: desc,
                                                                time: timeFormatted ?? "-",
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
    
    private func formatInningSections(homeInningPlays: PlaysPerInning, awayInningPlays: PlaysPerInning, innings: Int) -> [PlaysList.InningSectionViewModel] {
        
        var sectionsViewModel: [PlaysList.InningSectionViewModel] = []
        for i in 1..<innings + 1 {
            
            let topInningPlays = awayInningPlays[i] ?? []
            if !topInningPlays.isEmpty {
                
                let topSectionViewModel = PlaysList.InningSectionViewModel(inningNumber: i,
                                                                             inningName: "Top \(i)",
                                                                             plays: topInningPlays)
                sectionsViewModel.append(topSectionViewModel)
            }
            
            let botInningPlays = homeInningPlays[i] ?? []
            if !botInningPlays.isEmpty {
                let botSectionViewModel = PlaysList.InningSectionViewModel(inningNumber: i,
                                                                             inningName: "Bottom \(i)",
                                                                             plays: botInningPlays)
                
                sectionsViewModel.append(botSectionViewModel)
            }
        }
        
        return sectionsViewModel
    }
}
