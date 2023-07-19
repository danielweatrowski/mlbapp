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
    let homeTeamName: String
    let homeTeamRecord: String
    let homeTeamAbbreviation: String
    let homeTeamScore: Int
    let awayTeamName: String
    let awayTeamRecord: String
    let awayTeamAbbreviation: String
    let awayTeamScore: Int

    let bannerViewModel: StatusBannerViewModel
}

struct ScoresListGridItemView: View {
    let viewModel: ScoresListItemViewModel
    var body: some View {
        VStack(spacing: 0) {
            StatusBannerView(viewModel: viewModel.bannerViewModel)
            
            HStack() {
                VStack(alignment: .leading) {
                    Text(viewModel.homeTeamName)
                        .bold()
                    + Text(" \(viewModel.homeTeamAbbreviation)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .bold()
                    Text(viewModel.homeTeamRecord)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(String(viewModel.homeTeamScore))
                    .padding(.vertical)
                    .bold(viewModel.homeTeamScore > viewModel.awayTeamScore)
                    .font(.title3)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                
            }
            .font(.system(size: 17, weight: .medium, design: .default))
            .padding(.horizontal)
            
            HStack() {
                VStack(alignment: .leading) {
                    Text(viewModel.awayTeamName)
                        .bold()
                    + Text(" \(viewModel.awayTeamAbbreviation)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .bold()
                    Text(viewModel.awayTeamRecord)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(String(viewModel.awayTeamScore))
                    .padding(.vertical)
                    .bold(viewModel.homeTeamScore < viewModel.awayTeamScore)
                    .font(.title3)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                
            }
            .font(.system(size: 17, weight: .medium, design: .default))
            .padding(.horizontal)
        }
    }
}

struct ScoresListGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresListGridItemView(viewModel: .init(gameID: 1, homeTeamName: "Dodgers", homeTeamRecord: "0-0", homeTeamAbbreviation: "LAD", homeTeamScore: 10, awayTeamName: "Giants", awayTeamRecord: "0-0", awayTeamAbbreviation: "SF", awayTeamScore: 5, bannerViewModel: .init(statusText: "Top 8", backgroundColor: Color.green, chevronIndicator: false)))
            .frame(width: 200)
            .border(.red)
    }
}
