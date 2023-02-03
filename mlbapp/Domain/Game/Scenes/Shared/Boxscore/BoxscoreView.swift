//
//  BoxscoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import SwiftUI

struct EmptyGridItem: View {
    let color: Color = .clear
    
    var body: some View {
        color
        .frame(width: 20, height: 20)
    }
}

struct BoxscoreView: View {
    
    @Binding var viewModel: BoxscoreViewModel?
    @State private var teamBoxSelection = 0

    var body: some View {
        if let viewModel = viewModel {
            VStack {
                Picker("Teams", selection: $teamBoxSelection) {
                    Text("NYM").tag(0)
                    Text(viewModel.homeTeamAbbreviation).tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                ScrollView(.horizontal) {
                    Grid(verticalSpacing: 16) {
                        BoxscoreHeaderView(teamAbbreviation: viewModel.homeTeamAbbreviation)
                        Divider()
                        ForEach(viewModel.homeBatters, id: \.id) { batter in
                            BoxscoreRowView(viewModel: batter, type: .batter)
                        }
                        BoxscoreRowView(viewModel: viewModel.homeBattingTotals, type: .total)
                    }
                }
                .padding(.bottom, 16)
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(viewModel.homeNotes, id: \.self) {
                        Text($0)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        else {
            EmptyView()
        }
    }
}

struct BoxscoreView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreView(viewModel: .constant(BoxscoreViewModel.Seed.viewModel))
    }
}
