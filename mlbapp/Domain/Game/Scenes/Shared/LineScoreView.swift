//
//  LineScoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct LineScoreViewItem: Identifiable {
    enum ItemType {
        case team, header, run, stat, none
    }
    
    var id = UUID()
    var type: ItemType
    var value: String
    
    mutating func setValue(_ value: String) {
        self.value = value
    }
}

struct LineScoreView: View {
    
    @Binding var viewModel: LineScoreViewModel
    
    let columns = [
        GridItem(.flexible(minimum: 60, maximum: 100)),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.headers, id: \.id) { item in
                    switch(item.type) {
                    case .team:
                        Text(item.value)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    default:
                        Text(item.value)
                            .font(.subheadline)

                    }
                }
            }
            .padding(.horizontal)
            Divider()
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.data, id: \.id) { item in
                    switch(item.type) {
                    case .team:
                        Text(item.value)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    default:
                        Text(item.value)
                            .font(.subheadline)

                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 300)
    }
}

//struct LineScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        LineScoreView()
//            .previewLayout(.fixed(width: 400, height: 100))
//    }
//}
