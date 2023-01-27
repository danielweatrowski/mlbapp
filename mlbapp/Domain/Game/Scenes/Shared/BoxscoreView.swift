//
//  BoxscoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import SwiftUI

struct BoxscoreView: View {
    
    var viewModel: BoxscoreViewModel
    
    var rows: [GridItem] {
        return Array(repeating: GridItem(.fixed(40)), count: viewModel.items.count + 1)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                BoxscoreHeaderView()
                ForEach(viewModel.items, id: \.id) { item in
                    BoxscoreRowView()
                }
            }
        }
    }
}

struct BoxscoreView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreView(viewModel: BoxscoreViewModel.Seed.viewModel)
    }
}
