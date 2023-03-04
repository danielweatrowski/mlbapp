//
//  BoxscoreTotalsView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/27/23.
//

import SwiftUI

struct BoxscoreTotalsView: View {
    var viewModel: BoxscoreViewModel.Batter
    
    var body: some View {
        Text("Hello, Baseball")
//        GridRow {
//            Text("Totals")
//                .bold()
//
//            EmptyGridItem()
//            ForEach(range, id: \.self) { index in
//                Text(viewModel[index])
//                    .font(.subheadline)
//                    .bold()
//            }
//        }
    }
}

struct BoxscoreTotalsView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreTotalsView(viewModel: BoxscoreViewModel.Seed.viewModel.homeBattingTotals)
    }
}
