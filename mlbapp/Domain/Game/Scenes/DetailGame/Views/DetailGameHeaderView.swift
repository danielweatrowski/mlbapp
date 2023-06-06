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
                            LogoView(teamID: viewModel.homeTeamID,
                                     teamAbbreviation: viewModel.homeTeamAbbreviation);
                            Text(viewModel.homeTeamName)
                                .font(.subheadline)
                                .bold()
                                .multilineTextAlignment(.center)
                            Text(viewModel.homeTeamRecord)
                                .font(.caption2)
                        }
                        
                        VStack() {
                            Text(viewModel.homeTeamScore)
                                .font(.system(size: 48))
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .bold()
                                .padding([.leading, .trailing])
                            
                        }
                        
                        Text("-")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        VStack() {
                            Text(viewModel.awayTeamScore)
                                .font(.system(size: 48))
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .bold()
                                .padding([.leading, .trailing])
                        }
                        VStack(alignment: .center, spacing: 4) {
                            LogoView(teamID: viewModel.awayTeamID,
                                     teamAbbreviation: viewModel.awayTeamAbbreviation)
                            Text(viewModel.awayTeamName)
                                .font(.subheadline)
                                .bold()
                                .multilineTextAlignment(.center)
                            Text(viewModel.awayTeamRecord)
                                .font(.caption2)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .padding(.bottom)
            }
        }
        else {
            EmptyView()
        }
    }
}

struct DetailGameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = DetailGameHeaderViewModel(homeTeamName: "Dodgers", homeTeamAbbreviation: "LAD", homeTeamScore: "10", homeTeamRecord: "10-0", awayTeamName: "Giants", awayTeamAbbreviation: "SFG", awayTeamScore: "2", awayTeamRecord: "0-10")

        DetailGameHeaderView(viewModel: .constant(viewModel))
    }
}
