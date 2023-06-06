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
        VStack() {
            HStack() {
                gameStatusText
                Spacer()
                Text(viewModel.gameVenueName)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
                        
            HStack() {
                LogoView(teamID: viewModel.homeTeamID, teamAbbreviation: viewModel.homeTeamAbbreviation)
                VStack(alignment: .leading) {
                    Text(viewModel.homeTeamName)
                    Text(viewModel.homeTeamRecord)
                        .font(.caption)
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
                LogoView(teamID: viewModel.awayTeamID, teamAbbreviation: viewModel.awayTeamAbbreviation)
                VStack(alignment: .leading) {
                    Text(viewModel.awayTeamName)
                    Text(viewModel.awayTeamRecord)
                        .font(.caption)
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
                                  embedInScrollView: false)
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
    
    @ViewBuilder
    var gameStatusText: some View {
        if viewModel.isGameLive {
            Text(viewModel.gameStatusText.uppercased())
                .bold()
                .font(.subheadline)
                .foregroundColor(.green)
        } else {
            Text(viewModel.gameStatusText)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
    }

}

//struct ListGameRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = ListGameRowViewModel(gameID: 1, gameDate: "June 22, 2004",
//                                             gameVenueName: "The Sandlot",
//                                             homeTeamID: 119,
//                                             homeTeamName: "Rockstars",
//                                             homeTeamAbbreviation: "SDR",
//                                             homeTeamScore: "9",
//                                             homeTeamRecord: "10-1",
//                                             homeTeamLogoName: "",
//                                             awayTeamID: 114,
//                                             awayTeamName: "Dancers",
//                                             awayTeamAbbreviation: "SDD",
//                                             awayTeamScore: "3",
//                                             awayTeamRecord: "3-7",
//                                             awayTeamLogoName: "",
//                                             linescoreViewModel: nil)
//        ListGameRow(viewModel: viewModel)
//            .previewLayout(.fixed(width: 400, height: 200))
//    }
//}
