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
                
                Text(viewModel.gameDate)
                Spacer()
                Text(viewModel.gameVenueName)
            }
            .foregroundColor(.secondary)
            .font(.footnote)
                        
            HStack() {
                LogoView(teamID: viewModel.homeTeamID, teamAbbreviation: viewModel.homeTeamAbbreviation)
                VStack(alignment: .leading) {
                    Text(viewModel.homeTeamName)
                    Text(viewModel.homeTeamRecord)
                        .font(.caption)
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
                LogoView(teamID: viewModel.awayTeamID, teamAbbreviation: viewModel.awayTeamAbbreviation)
                VStack(alignment: .leading) {
                    Text(viewModel.awayTeamName)
                    Text(viewModel.awayTeamRecord)
                        .font(.caption)
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

struct ListGameRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ListGameRowViewModel(gameID: 1, gameDate: "June 22, 2004",
                                             gameVenueName: "The Sandlot",
                                             homeTeamID: 119,
                                             homeTeamName: "Rockstars",
                                             homeTeamAbbreviation: "SDR",
                                             homeTeamScore: "9",
                                             homeTeamRecord: "10-1",
                                             homeTeamLogoName: "",
                                             awayTeamID: 114,
                                             awayTeamName: "Dancers",
                                             awayTeamAbbreviation: "SDD",
                                             awayTeamScore: "3",
                                             awayTeamRecord: "3-7",
                                             awayTeamLogoName: "")
        ListGameRow(viewModel: viewModel)
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
