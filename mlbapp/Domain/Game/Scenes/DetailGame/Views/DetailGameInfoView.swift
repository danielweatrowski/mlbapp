//
//  DetailGameInfoView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/9/22.
//

import SwiftUI

struct DetailGameInfoView: View {
    @Binding var viewModel: DetailGame.InfoViewModel?
    
    var body: some View {
        if let viewModel = viewModel {
            VStack(alignment: .leading) {
                Text("Final")
                Text(viewModel.gameDate)
                Text(viewModel.venueName)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        } else {
            EmptyView()
        }
    }
}

struct DetailGameInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailGame.InfoViewModel(gameDate: "Wednesday, November 9, 2022", venueName: "Dan's Pad")
        DetailGameInfoView(viewModel: .constant(viewModel))
    }
}
