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
    
    var body: some View {
        if let viewModel = viewModel {
            VStack {
                ScrollView(.horizontal) {
                    Grid {
                        BoxscoreHeaderView(teamAbbreviation: viewModel.teamAbbreviation)
                        Divider()
                        ForEach(viewModel.items, id: \.id) { item in
                            BoxscoreRowView(viewModel: item)
                                .padding(.bottom, 4)
                        }
                        BoxscoreTotalsView(viewModel: viewModel.battingTotals)
                    }
                }
                .padding(.bottom, 16)
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(viewModel.notes, id: \.self) {
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
