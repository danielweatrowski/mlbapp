//
//  PreviewHeaderView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/17/23.
//

import SwiftUI
import Views

struct PreviewHeaderViewModel {
    var homeTeamName: String
    var homeTeamRecord: String
    var homeTeamAbbreviation: String
    var awayTeamName: String
    var awayTeamRecord: String
    var awayTeamAbbreviation: String
    var gameDateString: String
    var venueName: String
}

struct PreviewHeaderView: View {
    
    let viewModel: PreviewHeaderViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            StatusBannerView(viewModel: StatusBannerViewModel(statusText: "Scheduled", statusTextColor: .secondary, secondaryStatusText: viewModel.venueName, secondaryStatusTextColor: .secondary, backgroundColor: .clear, divider: true, chevronIndicator: false))
            
            HStack {
                Spacer()
                VStack {
                    Text(viewModel.awayTeamName)
                        .bold()
                        .font(.title2)
                    Text(viewModel.awayTeamAbbreviation)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(viewModel.awayTeamRecord)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()

                VStack {
                    Text(viewModel.homeTeamName)
                        .bold()
                        .font(.title2)
                    Text(viewModel.homeTeamAbbreviation)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(viewModel.homeTeamRecord)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.vertical)
            .padding(.top)
            
            VStack {
                Text(viewModel.gameDateString)
                    .padding()
                    .lineLimit(1)
                    .background(
                        Color
                            .secondary
                            .opacity(0.1)
                            .frame(maxWidth: .infinity)
                    )
                    .cornerRadius(12)
            }
            .padding(.bottom)
        }
    }
}
