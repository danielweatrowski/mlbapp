//
//  LogoViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/12/23.
//

import Foundation

class LogoViewModel: ObservableObject {
    let teamID: Int
    let abbreviation: String
    var logoService: LogoWorkerProtocol?
    
    @Published var logoData: Data?
    
    init(teamID: Int, abbreviation: String) {
        self.teamID = teamID
        self.abbreviation = abbreviation
    }
    
    var colorCode: String {
        return team.primaryColor
    }
    
    var team: ActiveTeam {
        return ActiveTeam.team(withIdentifier: teamID) ?? .unknown
    }
    
    func loadLogoData() {
        Task {
            let data = await logoService?.fetchLogoData(teamID: teamID)
            DispatchQueue.main.async {
                self.logoData = data
            }
        }
    }
}
