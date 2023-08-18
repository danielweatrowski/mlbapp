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
        
        // runs
        let runInfoItems: [StandingsDetail.ItemViewModel] = [
            .init(item: .runsAllowed, value: standing.runsAllowed.formatted()),
            .init(item: .runsScored, value: standing.runsScored.formatted()),
            .init(item: .runDiff, value: standing.runDifferential.formatted())
        ]
        let homeRecordStat = standing.homeRecord?.asStat()
        let awayRecordStat = standing.awayRecord?.asStat()
        let extraInningsRecordStat = standing.extraInningRecord?.asStat()
        let lastTenRecordStat = standing.last10?.asStat()
        let americanLeagueRecordStat = standing.americanLeagueRecord?.asStat()
        let nationalLeagueRecordStat = standing.nationalLeagueRecord?.asStat()
        
        let recordSplitItems: [StandingsDetail.ItemViewModel] = [
            .init(item: .home, value: homeRecordStat.unwrappedAndFormatted()),
            .init(item: .away, value: awayRecordStat.unwrappedAndFormatted()),
            .init(item: .extraInnings, value: extraInningsRecordStat.unwrappedAndFormatted()),
            .init(item: .last10, value: lastTenRecordStat.unwrappedAndFormatted()),
            .init(item: .american, value: americanLeagueRecordStat.unwrappedAndFormatted()),
            .init(item: .national, value: nationalLeagueRecordStat.unwrappedAndFormatted())
        ]
        
        let xRecordStat = standing.xWinLossRecord?.asStat()
        let xSeasonRecordStat = standing.xSeasonWinLossRecord?.asStat()
        
        let expectedRecordItems: [StandingsDetail.ItemViewModel] = [
            .init(item: .xRecord, value: xRecordStat.unwrappedAndFormatted()),
            .init(item: .xSeasonRecord, value: xSeasonRecordStat.unwrappedAndFormatted())
        ]
        
        let basicInfoSection = StandingsDetail.SectionViewModel(title: "General", items: basicInfoItems)
        let runsInfoSection = StandingsDetail.SectionViewModel(title: "Runs", items: runInfoItems)
        let recordSplitInfoSection = StandingsDetail.SectionViewModel(title: "Record Splits", items: recordSplitItems)
        let expectedRecordInfoItems = StandingsDetail.SectionViewModel(title: "Expected Splits", items: expectedRecordItems)
        
        let viewInput = StandingsDetail.ViewInput(sections: [basicInfoSection, runsInfoSection, recordSplitInfoSection, expectedRecordInfoItems])
        
        viewModel.renderNavigationTitle("\(standing.teamAbbreviation) (\(standing.season))")
        viewModel.renderStandingsDetail(input: viewInput)
    }
}
