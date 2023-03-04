//
//  TeamIconView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import SwiftUI

struct TeamIconView: View {
    
    let abbreviation: String
    let color: Color
    let size: CGSize = CGSize(width: 46, height: 46)
    
    var body: some View {
        Text("LAD")
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(.blue)
                    .frame(width: size.width, height: size.height)
            )
    }
}

struct TeamIconView_Previews: PreviewProvider {
    static var previews: some View {
        TeamIconView(abbreviation: "LAD", color: Color(hex: "005A9C"))
    }
}
