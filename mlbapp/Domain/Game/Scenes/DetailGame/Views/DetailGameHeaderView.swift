//
//  DetailGameHeaderView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct DetailGameHeaderView: View {
    @Binding var viewModel: DetailGame.HeaderViewModel?
    
    var body: some View {
        if let viewModel = viewModel {
            HStack() {
                Spacer()

                VStack(alignment: .center) {
                    Image("\(viewModel.homeTeam)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80, maxHeight: 80)
                    Text("Mets")
                        .font(.subheadline)
                        .bold()
                    Text(viewModel.homeTeamRecord)
                        .font(.caption2)
                }
                
                VStack() {
                    Text(viewModel.homeTeamScore)
                        .font(.system(size: 56))
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
                        .font(.system(size: 56))
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .bold()
                        .padding([.leading, .trailing])
                }
                VStack(alignment: .center) {
                    Image("\(viewModel.awayTeam)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80, maxHeight: 80)
                    Text("Phillies")
                        .font(.subheadline)
                        .bold()
                    Text(viewModel.awayTeamRecord)
                        .font(.caption2)
                }

                Spacer()
                
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
        
        let viewModel = DetailGame.HeaderViewModel(homeTeam: .dodgers, homeTeamScore: "7", homeTeamRecord: "10-2", awayTeam: .braves, awayTeamScore: "2", awayTeamRecord: "2-10")

        DetailGameHeaderView(viewModel: .constant(viewModel))
    }
}
