//
//  BoxscoreTotalsView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/27/23.
//

import SwiftUI

struct BoxscoreTotalsView: View {
    var viewModel: [String]
    private let range = [0,1,2,3,4,5,6]
    
    var body: some View {
        GridRow {
            Text("Totals")
                .bold()
            
            EmptyGridItem()
            ForEach(range, id: \.self) { index in
                Text(viewModel[index])
                    .font(.subheadline)
                    .bold()
            }
        }
    }
}

struct BoxscoreTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreTotalsView(viewModel: BoxscoreViewModel.Seed.viewModel.battingTotals)
    }
}
