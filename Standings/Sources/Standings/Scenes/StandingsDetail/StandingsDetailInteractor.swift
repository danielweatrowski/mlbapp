//
//  StandingsDetailInteractor.swift
//  
//
//  Created by Daniel Weatrowski on 8/13/23.
//

import Foundation
import Models

protocol StandingsDetailBusinessLogic {
    func loadTeamStanding()
}

protocol StandingsDetailDataStore {
    var teamStanding: Standings.TeamRecord { get }
}

struct StandingsDetailInteractor<P>: StandingsDetailBusinessLogic & StandingsDetailDataStore where P : StandingsDetailPresentationLogic {
    
    var teamStanding: Standings.TeamRecord
    let presenter: P?
    
    func loadTeamStanding() {
        let output = StandingsDetail.Output(standing: teamStanding)
        presenter?.presentStandingsDetail(output: output)
    }
    
}
