//
//  DetailPlayerPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import Foundation

protocol DetailPlayerPresentationLogic {
    func presentPlayer(response: DetailPlayer.Response)
}

struct DetailPlayerPresenter: DetailPlayerPresentationLogic {
    
    var viewModel: DetailPlayerViewModel
    
    func presentPlayer(response: DetailPlayer.Response) {
//        DispatchQueue.main.async {
//            viewModel.fullName = response.player.fullName
//            viewModel.nickname = response.player.nickname ?? ""
//            viewModel.number = response.player.primaryNumber
//            viewModel.headShotURL = SwiftMLBRequest.headshot(response.player.id).url
//            viewModel.teamColorAsHex = "C41E3A"
//        }
    }
}
