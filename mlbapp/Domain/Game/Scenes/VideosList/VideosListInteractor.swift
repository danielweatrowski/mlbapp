//
//  VideosListInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import Foundation

protocol VideosListBusinessLogic {
    func loadVideos() async throws
}

protocol VideosListDataStore {
    var gameID: Int { get }
}

struct VideosListInteractor: VideosListBusinessLogic & VideosListDataStore {
    
    let presenter: VideosListPresentationLogic
    var gameID: Int
    
    func loadVideos() async throws {
        
    }
    
}
