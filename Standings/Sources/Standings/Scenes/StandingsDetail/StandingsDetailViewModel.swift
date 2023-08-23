//
//  File.swift
//  
//
//  Created by Daniel Weatrowski on 8/13/23.
//

import Foundation

protocol StandingsDetailRenderingLogic {
    func renderStandingsDetail(input: StandingsDetail.ViewInput)
}

class StandingsDetailViewModel: ObservableObject {
    
    enum State {
        case loading, loaded, error
    }
    var interactor: (StandingsDetailBusinessLogic & StandingsDetailDataStore)?
    
    @Published var state: State = .loading
    var sections: [StandingsDetail.SectionViewModel] = []
    var teamAbbreviation: String
    var season: String
    
    var navigationTitle: String {
        "\(teamAbbreviation) (\(season))"
    }
    
    init(teamAbbreviation: String, season: String) {
        self.teamAbbreviation = teamAbbreviation
        self.season = season
    }
}

extension StandingsDetailViewModel: StandingsDetailRenderingLogic {
    
    func renderStandingsDetail(input: StandingsDetail.ViewInput) {
        self.sections = input.sections
        
        DispatchQueue.main.async {
            self.state = .loaded
        }
    }
}
