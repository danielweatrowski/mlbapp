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
                VStack(alignment: .center, spacing: 2) {
                    Image("\(viewModel.homeTeamName)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80, maxHeight: 80)
                    Text(viewModel.homeTeamName)
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(viewModel.homeTeamRecord)
                        .font(.caption2)
                }
                
                VStack() {
                    Text(viewModel.homeTeamScore)
                        .font(.system(size: 40))
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
                        .font(.system(size: 40))
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .bold()
                        .padding([.leading, .trailing])
                }
                VStack(alignment: .center, spacing: 2) {
                    Image("\(viewModel.awayTeamName)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80, maxHeight: 80)
                    Text(viewModel.awayTeamName)
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(viewModel.awayTeamRecord)
                        .font(.caption2)
                }
            }
            .cornerRadius(16)
        }
        else {
            EmptyView()
        }
    }
}

struct DetailGameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = DetailGameHeaderViewModel(homeTeamName: "Dodgers", homeTeamScore: "10", homeTeamRecord: "10-0", awayTeamName: "Giants", awayTeamScore: "2", awayTeamRecord: "0-10")

        DetailGameHeaderView(viewModel: .constant(viewModel))
    }
}
