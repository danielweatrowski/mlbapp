//
//  DetailGameHeaderView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI
import Views

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
                                .font(.title2)
                                .bold()
                            + Text(" \(viewModel.homeTeamAbbreviation)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .bold()
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
                                .font(.title2)
                                .bold()
                            + Text(" \(viewModel.awayTeamAbbreviation)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .bold()
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
