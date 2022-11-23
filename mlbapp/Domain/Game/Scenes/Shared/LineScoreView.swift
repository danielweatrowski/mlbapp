//
//  LineScoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct LineScoreItem: Identifiable {
    enum ItemType {
        case team, header, run, stat, none
    }
    
    var id = UUID()
    var type: ItemType
    var value: String
}

struct LineScoreView: View {
    let headers: [LineScoreItem] = [
        LineScoreItem(type: .none, value: ""),
        LineScoreItem(type: .header, value: "1"),
        LineScoreItem(type: .header, value: "2"),
        LineScoreItem(type: .header, value: "3"),
        LineScoreItem(type: .header, value: "4"),
        LineScoreItem(type: .header, value: "5"),
        LineScoreItem(type: .header, value: "6"),
        LineScoreItem(type: .header, value: "7"),
        LineScoreItem(type: .header, value: "8"),
        LineScoreItem(type: .header, value: "9"),
        LineScoreItem(type: .none, value: ""),
        LineScoreItem(type: .header, value: "R"),
        LineScoreItem(type: .header, value: "H"),
        LineScoreItem(type: .header, value: "E"),

    ]
//    let headers = ["", "1", "2","3","4","5","6","7","8","9", "", "R", "H", "E"]
    let homeTeamData: [LineScoreItem] = [
        LineScoreItem(type: .team, value: "LAD"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .none, value: ""),
        LineScoreItem(type: .stat, value: "0"),
        LineScoreItem(type: .stat, value: "0"),
        LineScoreItem(type: .stat, value: "0")
    ]
    
    let awayTeamData: [LineScoreItem] = [
        LineScoreItem(type: .team, value: "OAK"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .run, value: "0"),
        LineScoreItem(type: .none, value: ""),
        LineScoreItem(type: .stat, value: "0"),
        LineScoreItem(type: .stat, value: "0"),
        LineScoreItem(type: .stat, value: "0")
    ]
//    let awayTeamData = ["OAK", "j", "k","l","m","n","o","p","q","r", "", "X", "Y", "Z"]
    
    var data: [LineScoreItem] {
        return homeTeamData + awayTeamData
    }
    
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
                ForEach(headers, id: \.id) { item in
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
                ForEach(data, id: \.id) { item in
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

struct LineScoreView_Previews: PreviewProvider {
    static var previews: some View {
        LineScoreView()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
