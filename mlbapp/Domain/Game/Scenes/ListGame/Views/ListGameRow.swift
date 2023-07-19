//
//  ListGameRow.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import SwiftUI

struct ListGameRow: View {
    
    var viewModel: ListGameRowViewModel

    var body: some View {
        VStack(spacing: 0) {
            
            banner
            
            VStack(spacing: 10) {
                
                HStack() {
                    //LogoView(teamID: viewModel.homeTeamID, teamAbbreviation: viewModel.homeTeamAbbreviation)
                    VStack(alignment: .leading) {
                        Text(viewModel.homeTeamName)
                        Text(viewModel.homeTeamRecord)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if viewModel.isGameLiveOrFinal {
                        Text(String(viewModel.homeTeamScore))
                            .padding()
                            .font(.title3)
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                            .frame(width: 56)
                            .background(
                                Color.secondary.opacity(0.1)
                                    .frame(maxWidth: .infinity)
                            )
                            .cornerRadius(12)
                    }
                    
                    
                }
                .font(.system(size: 17, weight: .medium, design: .default))
                
                HStack() {
                    //LogoView(teamID: viewModel.awayTeamID, teamAbbreviation: viewModel.awayTeamAbbreviation)
                    VStack(alignment: .leading) {
                        Text(viewModel.awayTeamName)
                        Text(viewModel.awayTeamRecord)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if viewModel.isGameLiveOrFinal {
                        Text(String(viewModel.awayTeamScore))
                            .padding()
                            .font(.title3)
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                            .frame(width: 56)
                            .background(
                                Color
                                    .secondary
                                    .opacity(0.1)
                                    .frame(maxWidth: .infinity)
                            )
                            .cornerRadius(12)
                    }
                    
                }
                .font(.system(size: 17, weight: .medium, design: .default))
                
                if viewModel.showLinescore {
                    Divider()
                    LinescoreGridView(viewModel: .constant(viewModel.linescoreViewModel),
                                      embedInScrollView: true)
                    .listRowInsets(EdgeInsets())
                }
                
                if viewModel.showDecisions, let winner = viewModel.winningPitcherName, let loser = viewModel.losingPitcherName {
                    Divider()
                    HStack {
                        HStack {
                            Text("W:")
                                .bold()
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(winner)
                                .font(.subheadline)
                        }
                        HStack {
                            Text("L:")
                                .bold()
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(loser)
                                .font(.subheadline)
                        }
                        
                        if let saver = viewModel.savePitcherName {
                            HStack {
                                Text("S:")
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(saver)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding()
        }
        .background(.clear)
    }
    
    @ViewBuilder
    var banner: some View {
        if let bannerViewModel = viewModel.statusBannerViewModel {
            StatusBannerView(viewModel: bannerViewModel)
        }
    }
}
