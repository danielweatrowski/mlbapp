//
//  BoxscoreRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import SwiftUI

struct BoxscoreRowView: View {
    
    var viewModel: BoxscoreViewModel.Batter
    
    var body: some View {
        GridRow {
            nameField
                .gridColumnAlignment(.leading)
            EmptyGridItem()
            
            Text(viewModel.atBats)
                .font(.subheadline)
            
            Text(viewModel.runs)
                .font(.subheadline)

            Text(viewModel.hits)
                .font(.subheadline)

            Text(viewModel.runsBattedIn)
                .font(.subheadline)

            Text(viewModel.baseOnBalls)
                .font(.subheadline)

            Text(viewModel.strikeOuts)
                .font(.subheadline)

            Text(viewModel.leftOnBase)
                .font(.subheadline)

            Text(viewModel.average)
                .font(.subheadline)

        }
    }
    
    @ViewBuilder
    var nameField: some View {
        if viewModel.substitution {
            Text("    ")
            + Text(viewModel.name)
                .bold()
                .font(.subheadline)
            + Text("  \(viewModel.positionAbbreviation)")
                .font(.footnote)
                .foregroundColor(.secondary)
        } else {
            Text(viewModel.name)
                .bold()
                .font(.subheadline)
            + Text("  \(viewModel.positionAbbreviation)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct BoxscoreRowView_Previews: PreviewProvider {
    static var previews: some View {
        Grid {
            BoxscoreRowView(viewModel: BoxscoreViewModel.Seed.harper_20190424)
        }
    }
}
