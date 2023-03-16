//
//  BoxscoreRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import SwiftUI

struct BoxscoreRowView: View {
    
    var viewModel: BoxscoreRowViewModel
    
    var body: some View {
        GridRow {
            titleField
                .gridColumnAlignment(.leading)
                            
            Text(viewModel.item0)
                .font(.subheadline)
                .bold(viewModel.boldItems)
            
            Text(viewModel.item1)
                .font(.subheadline)
                .bold(viewModel.boldItems)

            Text(viewModel.item2)
                .font(.subheadline)
                .bold(viewModel.boldItems)

            Text(viewModel.item3)
                .font(.subheadline)
                .bold(viewModel.boldItems)

            Text(viewModel.item4)
                .font(.subheadline)
                .bold(viewModel.boldItems)

            Text(viewModel.item5)
                .font(.subheadline)
                .bold(viewModel.boldItems)

            Text(viewModel.item6)
                .font(.subheadline)
                .bold(viewModel.boldItems)

            Text(viewModel.item7)
                .font(.subheadline)
                .bold(viewModel.boldItems)
        }
    }
    
    @ViewBuilder
    var titleField: some View {
        if viewModel.indentTitle {
            Text("  ")
            + Text(viewModel.title)
                .bold()
                .font(.subheadline)
            + Text("  \(viewModel.subtitle)")
                .font(.footnote)
                .foregroundColor(.secondary)
        } else {
            Text(viewModel.title)
                .bold()
                .font(.subheadline)
            + Text("  \(viewModel.subtitle)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct BoxscoreRowView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = BoxscoreRowViewModel(title: "Title", subtitle: "Subtitle", item0: "0", item1: "0", item2: "0", item3: "0", item4: "0", item5: "0", item6: "0", item7: "0")
        Grid {
            BoxscoreRowView(viewModel: vm)
        }
    }
}
