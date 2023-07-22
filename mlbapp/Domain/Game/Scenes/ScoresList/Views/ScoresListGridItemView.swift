//
//  ScoresListGridItemView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/17/23.
//

import SwiftUI

struct ScoresListItemViewModel {
    let id: UUID = UUID()
    let gameID: Int
    let gameStatus: GameStatus
    let homeTeamName: String
    let homeTeamRecord: String
    let homeTeamAbbreviation: String
    let homeTeamScore: String
    let awayTeamName: String
    let awayTeamRecord: String
    let awayTeamAbbreviation: String
    let awayTeamScore: String

    let bannerViewModel: StatusBannerViewModel
}

struct ScoresListGridItemView: View {
    
    @EnvironmentObject private var theme: Theme
    
    let viewModel: ScoresListItemViewModel
    
    var isCompact: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            banner
            
            HStack() {
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text(viewModel.homeTeamName)
                            .bold()
                        if !isCompact {
                            Text(viewModel.homeTeamAbbreviation)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .bold()
                        }
                    }
                    Text(viewModel.homeTeamRecord)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(String(viewModel.homeTeamScore))
                    .padding(.vertical)
                    .font(.title3)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                
            }
            .font(.system(size: 17, weight: .medium, design: .default))
            .padding(.horizontal)
            
            HStack() {
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text(viewModel.awayTeamName)
                            .bold()
                        if !isCompact {
                            Text(viewModel.awayTeamAbbreviation)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .bold()
                        }
                    }
                    Text(viewModel.awayTeamRecord)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(String(viewModel.awayTeamScore))
                    .padding(.vertical)
                    .font(.title3)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                
            }
            .font(.system(size: 17, weight: .medium, design: .default))
            .padding(.horizontal)
        }
        .applyThemeSecondaryBackround(theme)
    }
    
    @ViewBuilder
    var banner: some View {
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.bannerViewModel.statusText)
                    .bold()
                    .foregroundColor(viewModel.bannerViewModel.statusTextColor)
                    .font(.subheadline)
                
                Spacer()
                if !isCompact, let secondaryStatusText = viewModel.bannerViewModel.secondaryStatusText {
                    Spacer()
                    Text(secondaryStatusText)
                        .font(.subheadline)
                        .foregroundColor(viewModel.bannerViewModel.secondaryStatusTextColor)
                    
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(viewModel.bannerViewModel.backgroundColor)
        }
        
        if viewModel.bannerViewModel.divider {
            Divider()
        }
    }
}
