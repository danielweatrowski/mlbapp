//
//  TeamViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import Foundation
import Combine

@MainActor
class TeamViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var stadium: String = ""
    @Published var firstYearOfPlay = ""
    
    var cancellation: AnyCancellable?
    
    init(id: Int) {
        self.id = id
        getTeam(withID: id)
    }
}

extension TeamViewModel {
    func getTeam(withID id: Int) {
        cancellation = SwiftMLB.team(withIdentifer: id)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { teams in
                
                guard let team = teams.first else {
                    return
                }
                
                self.name = team.name
                self.stadium = team.venue.name
                self.firstYearOfPlay = team.firstYearOfPlay
            })
    }
}
