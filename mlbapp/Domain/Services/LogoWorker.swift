//
//  LogoWorker.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/12/23.
//

import Foundation

protocol LogoWorkerProtocol {
    func fetchLogoData(teamID: Int) async -> Data?
}

struct LogoWorker<Store: LogoWorkerProtocol>: LogoWorkerProtocol {

    let store: Store
    
    func fetchLogoData(teamID: Int) async -> Data? {
        return await store.fetchLogoData(teamID: teamID)
    }
}
