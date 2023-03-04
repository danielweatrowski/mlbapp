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
            HStack() {
                Spacer()
                VStack(alignment: .center, spacing: 4) {
                    TeamIconView(abbreviation: viewModel.homeTeamAbbreviation, color: .blue)
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

                Text("FINAL")
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
                    TeamIconView(abbreviation: viewModel.awayTeamAbbreviation, color: .orange)
                    Text(viewModel.awayTeamName)
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(viewModel.awayTeamRecord)
                        .font(.caption2)
                }
                Spacer()
            }
            .padding(.vertical)
            .background()
            .cornerRadius(16)
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
