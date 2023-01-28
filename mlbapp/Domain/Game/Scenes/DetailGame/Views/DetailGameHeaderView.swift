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
                Image("\(viewModel.homeTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                VStack() {
                    Text(viewModel.homeTeamScore)
                        .font(.system(size: 66))
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                    Text(viewModel.homeTeamRecord)
                        .font(.caption2)
                }

                Spacer()
                Text("-")
                Spacer()

                VStack() {
                    Text(viewModel.awayTeamScore)
                        .font(.system(size: 66))
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                    Text(viewModel.awayTeamRecord)
                        .font(.caption2)
                }
                Image("\(viewModel.awayTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
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
