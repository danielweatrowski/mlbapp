//
//  DetailGameHeaderView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct DetailGameHeaderView: View {
    @Binding var viewModel: DetailGameHeaderViewModel?
    
    var body: some View {
        if let viewModel = viewModel {
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
                    .font(.system(size: 17, weight: .medium, design: .default))
                }
                .padding()
            }
            /*
            VStack(spacing: 0) {
                
                if viewModel.showStatusBanner, let statusText = viewModel.statusText, let backgroundColor = viewModel.statusBackgroundColor {
                    StatusBannerView(statusText: statusText,
                                     backgroundColor: backgroundColor)
                }
                
                
                VStack {
                    HStack {
                        Text(viewModel.gameDate)
                        Spacer()
                        Text(viewModel.venueName)
                    }
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.horizontal, .vertical])
                    
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .center, spacing: 4) {
//                            LogoView(teamID: viewModel.homeTeamID,
//                                     teamAbbreviation: viewModel.homeTeamAbbreviation);
                            Text(viewModel.homeTeamName)
                                .bold()
                                .multilineTextAlignment(.center)
                            Text(viewModel.homeTeamRecord)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack() {
                            Text(viewModel.homeTeamScore)
                                .font(.system(size: 38))
//                                .scaledToFill()
//                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .bold()
                                .padding([.leading, .trailing])
                            
                        }
                        
                        Text("-")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        VStack() {
                            Text(viewModel.awayTeamScore)
                                .font(.system(size: 38))
//                                .scaledToFill()
//                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .bold()
                                .padding([.leading, .trailing])
                        }
                        VStack(alignment: .center, spacing: 4) {
//                            LogoView(teamID: viewModel.awayTeamID,
//                                     teamAbbreviation: viewModel.awayTeamAbbreviation)
                            Text(viewModel.awayTeamName)
                                .bold()
                                .multilineTextAlignment(.center)
                            Text(viewModel.awayTeamRecord)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .padding(.bottom)
            }
             */
        }
        else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var banner: some View {
        if let viewModel = viewModel?.statusBannerViewModel {
            StatusBannerView(viewModel: viewModel)
        }
    }
}

struct DetailGameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = DetailGameHeaderViewModel(homeTeamName: "Dodgers", homeTeamAbbreviation: "LAD", homeTeamScore: "10", homeTeamRecord: "10-0", awayTeamName: "Giants", awayTeamAbbreviation: "SFG", awayTeamScore: "2", awayTeamRecord: "0-10")

        DetailGameHeaderView(viewModel: .constant(viewModel))
    }
}
