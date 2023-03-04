//
//  BoxscoreRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import SwiftUI

struct BoxscoreRowView: View {
    
    enum RowType {
        case batter, total
    }
    
    var viewModel: BoxscoreViewModel.Batter
    var type: RowType
    
    var body: some View {
        GridRow {
            nameField
                .gridColumnAlignment(.leading)
                
            EmptyGridItem()
            
            Text(viewModel.atBats)
                .font(.subheadline)
                .bold(type == .total)
            
            Text(viewModel.runs)
                .font(.subheadline)
                .bold(type == .total)

            Text(viewModel.hits)
                .font(.subheadline)
                .bold(type == .total)

            Text(viewModel.runsBattedIn)
                .font(.subheadline)
                .bold(type == .total)

            Text(viewModel.baseOnBalls)
                .font(.subheadline)
                .bold(type == .total)

            Text(viewModel.strikeOuts)
                .font(.subheadline)
                .bold(type == .total)

            Text(viewModel.leftOnBase)
                .font(.subheadline)
                .bold(type == .total)

            Text(viewModel.average)
                .font(.subheadline)
                .bold(type == .total)
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
            BoxscoreRowView(viewModel: BoxscoreViewModel.Seed.harper_20190424, type: .batter)
        }
    }
}
