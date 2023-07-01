//
//  RosterDetailPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

protocol RosterDetailPresentationLogic: SceneErrorPresentable {
    func presentRoster(output: RosterDetail.Output)
}

struct RosterDetailPresenter: RosterDetailPresentationLogic {
    
    let viewModel: RosterDetail.ViewModel
    
    func presentRoster(output: RosterDetail.Output) {
        
    }
    
    func presentSceneError(_ sceneError: SceneError) {
        
    }
}
