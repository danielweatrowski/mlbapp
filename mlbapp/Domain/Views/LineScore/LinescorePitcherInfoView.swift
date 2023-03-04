//
//  LinescorePitcherView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/4/23.
//

import SwiftUI

struct LinescorePitcherInfoViewModel {
    var winningPitcherName: String
    var winningPitcherWins: Int
    var winningPitcherLosses: Int
    var winningPitcherERA: String
    var losingPitcherName: String
    var losingPitcherWins: Int
    var losingPitcherLosses: Int
    var losingPitcherERA: String
}

struct LinescorePitcherInfoView: View {
    
    var viewModel: LinescorePitcherInfoViewModel?

    var body: some View {
        if let viewModel = viewModel {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("W:")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(viewModel.winningPitcherName)
                            .bold()
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack {
                        Text("\(viewModel.winningPitcherWins)-\(viewModel.winningPitcherLosses)")
                            .font(.footnote)
                        Divider()
                        Text("\(viewModel.winningPitcherERA) ERA")
                            .font(.footnote)
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("L:")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(viewModel.losingPitcherName)
                            .bold()
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack {
                        Text("\(viewModel.losingPitcherWins)-\(viewModel.losingPitcherLosses)")
                            .font(.footnote)
                        Divider()
                        Text("\(viewModel.losingPitcherERA) ERA")
                            .font(.footnote)
                        Spacer()
                    }
                }
                Spacer()
            }
        } else {
            EmptyView()
        }
    }
}

struct LinescorePitcherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LinescorePitcherInfoView()
    }
}
