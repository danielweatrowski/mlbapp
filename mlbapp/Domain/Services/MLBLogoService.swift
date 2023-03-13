//
//  MLBLogoService.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/12/23.
//

import Foundation

actor MLBLogoService: LogoWorkerProtocol, ObservableObject {
    
    private var cache = [URL: Data]()
    
    func fetchLogoData(teamID: Int) async -> Data? {
        let url = URL(string: "https://www.mlbstatic.com/team-logos/\(teamID).svg")!
        
        if let cached = cache[url] {
            return cached
        }
        
        let data = try? await URLSession.shared.data(from: url).0
        return data
    }
}
