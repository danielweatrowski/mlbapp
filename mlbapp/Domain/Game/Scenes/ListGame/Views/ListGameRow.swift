//
//  ListGameRow.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/4/22.
//

import SwiftUI

struct ListGameRow: View {
    
    var viewModel: ListGame.GameLookupItem.ViewModel
    
    private var homeRecord: String {
        return "\(viewModel.game.homeTeamWins)-\(viewModel.game.homeTeamLosses)"
    }
    private var awayRecord: String {
        return "\(viewModel.game.awayTeamWins)-\(viewModel.game.awayTeamLosses)"
    }
    
    private var awayTeamDidWin: Bool {
        return viewModel.game.awayTeamScore > viewModel.game.homeTeamScore
    }
    
    private var homeTeamDidWin: Bool {
        return viewModel.game.awayTeamScore < viewModel.game.homeTeamScore
    }

    var body: some View {
        VStack() {
            HStack() {
                
                Text(viewModel.game.date.formatted())
                Spacer()
                Text(viewModel.game.venue.name)
            }
            .foregroundColor(.secondary)
            .font(.footnote)
                        
            HStack() {
                Image("\(viewModel.game.homeTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 40)
                VStack(alignment: .leading) {
                    Text(viewModel.game.homeTeam.name)
                    Text(homeRecord)
                        .font(.caption)
                }
                
                Spacer()
                
                Text(String(viewModel.game.homeTeamScore))
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
                Image("\(viewModel.game.awayTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 40)
                VStack(alignment: .leading) {
                    Text(viewModel.game.awayTeam.name)
                    Text(awayRecord)
                        .font(.caption)
                }
                
                Spacer()
                
                Text(String(viewModel.game.awayTeamScore))
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
        let game = MLBGame.test_0
        let viewModel = ListGame.GameLookupItem.ViewModel(game: game)
        ListGameRow(viewModel: viewModel)
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
