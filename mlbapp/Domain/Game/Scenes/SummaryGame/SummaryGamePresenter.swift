//
//  SummaryGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/12/23.
//

import Foundation

protocol SummaryGamePresentationLogic {
    func presentGameSummary(output: SummaryGame.Output<Play>)
}

struct SummaryGamePresenter: SummaryGamePresentationLogic {
    
    let viewModel: SummaryGame.ViewModel
    
    func presentGameSummary(output: SummaryGame.Output<Play>) {
        
        var inningHash: [String: [SummaryGame.InningPlayViewModel]] = [:]
        
        for play in output.plays {
            let inningHashID = "\(play.about.halfInning.capitalized) \(play.about.inning)"
            let playViewModel = SummaryGame.InningPlayViewModel(eventName: play.result.event,
                                                                description: play.result.description,
                                                                numberOfOuts: nil)
            
            if inningHash[inningHashID] != nil {
                inningHash[inningHashID]?.append(playViewModel)
            } else {
                inningHash[inningHashID] = []
                inningHash[inningHashID]?.append(playViewModel)
            }
        }
        
        var sectionsViewModel: [SummaryGame.InningSectionViewModel] = []
        inningHash.forEach {
            let sectionViewModel = SummaryGame.InningSectionViewModel(inningNumber: 1,
                                                                      inningName: $0,
                                                                      plays: $1)
            sectionsViewModel.append(sectionViewModel)
        }
        
        DispatchQueue.main.async {
            viewModel.sections = sectionsViewModel
        }
    }

}
