//
//  ListGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import UIKit
import SwiftUI

struct ListGameView: View {
    
    var viewModel: ListGame.ViewModel
    
    var interactor: ListGameBusinessLogic?
    @ObservedObject var router: ListGameRouter
    
    var columns = [
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.rows, id: \.id) { row in
                    
                    NavigationLink(destination: {
                        DetailGameConfigurator.configure(for: row.gameID)
                        
                    }, label: {
                        ListGameRow(viewModel: row)
                            .background()
                            .cornerRadius(20)
                        
                    })
                    .buttonStyle(PlainButtonStyle())

                
//                    NavigationSplitView {
//                        ListGameRow(viewModel: row)
//                            .background()
//                            .cornerRadius(20)
//                    } detail: {
//                        DetailGameConfigurator.configure(for: row.gameID)
//                    }
                    
                }
                .padding([
                    .bottom,
                    .leading,
                    .trailing
                ])
            }
        }
        .background(
            Color(uiColor: .systemGroupedBackground)
        )

        .navigationTitle("Lookup Results")
    }
}

struct ListGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = ListGame.ViewModel(rows: [])
        ListGameView(viewModel: viewModel, router: ListGameRouter())
    }
}
