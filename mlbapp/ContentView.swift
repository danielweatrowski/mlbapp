//
//  ContentView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TeamViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .font(.title)
            Text(viewModel.stadium)
                .font(.title2)
            Text("Est. " + viewModel.firstYearOfPlay)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel:
                TeamViewModel(id: 130)
            )
    }
}
