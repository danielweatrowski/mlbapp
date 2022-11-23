//
//  DetailGameInfoView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/9/22.
//

import SwiftUI

struct DetailGameInfoView: View {
    @Binding var viewModel: DetailGame.DetailGame.ViewModel.InfoViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Final")
            Text(viewModel.gameDate)
            Text(viewModel.venueName)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}

struct DetailGameInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailGame.DetailGame.ViewModel.InfoViewModel(gameDate: "Wednesday, November 9, 2022", venueName: "Dan's Pad")
        DetailGameInfoView(viewModel: .constant(viewModel))
    }
}
