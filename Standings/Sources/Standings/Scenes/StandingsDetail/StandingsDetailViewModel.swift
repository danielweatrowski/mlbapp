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
    var navigationTitle: String = ""
}

extension StandingsDetailViewModel: StandingsDetailRenderingLogic {
    func renderStandingsDetail(input: StandingsDetail.ViewInput) {
        self.sections = input.sections
        
        DispatchQueue.main.async {
            self.state = .loaded
        }
    }
}
