//
//  BoxscoreHeaderView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/25/23.
//

import SwiftUI

struct BoxscoreHeaderView: View {
    
    var columns: [GridItem] = [
        GridItem(.fixed(120)),
        GridItem(.flexible()),
        GridItem(.fixed(28)),
        GridItem(.fixed(28)),
        GridItem(.fixed(28)),
        GridItem(.fixed(28)),
        GridItem(.fixed(28)),
        GridItem(.fixed(28)),
        GridItem(.fixed(36)),
        GridItem(.fixed(36)),
    ]
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                Text("Batters - LAD")
                    .bold()
                
                Spacer()
                
                Text("AB")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("R")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("H")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("RBI")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("BB")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("SO")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("LOB")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("AVG")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.secondary)

            }
            Divider()
        }
    }
}

struct BoxscoreHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreHeaderView()
    }
}
