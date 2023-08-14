//
//  StandingsDetailPresenter.swift
//  
//
//  Created by Daniel Weatrowski on 8/13/23.
//

import Foundation

protocol StandingsDetailPresentationLogic {
    func presentStandingsDetail(output: StandingsDetail.Output)
}

struct StandingsDetailPresenter<V>: StandingsDetailPresentationLogic where V: StandingsDetailRenderingLogic {
    
    let viewModel: V
    
    func presentStandingsDetail(output: StandingsDetail.Output) {
        let standing = output.standing
        
        // basic info
        let basicInfoItems: [StandingsDetail.ItemViewModel] = [
            .init(item: .wins, value: standing.wins.formatted()),
            .init(item: .losses, value: standing.losses.formatted()),
            .init(item: .winningPCT, value: standing.winPercentage.formatted(.decimal)),
            .init(item: .gamesBehind, value: standing.gamesBehind.formatted()),
            .init(item: .wildcardGamesBehind, value: standing.wildCardGamesBack.formatted())
        ]
        let basicInfoSection = StandingsDetail.SectionViewModel(title: "", items: basicInfoItems)
        let viewInput = StandingsDetail.ViewInput(sections: [basicInfoSection])
        viewModel.renderStandingsDetail(input: viewInput)
    }
}
