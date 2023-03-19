//
//  ListSection.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/19/23.
//

import SwiftUI

struct ListSection<Content> : View where Content : View {
    
    let title: String?
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(spacing: 8) {
            titleView
                .padding(.horizontal)
            content
                .frame(maxWidth: .infinity)
                .padding()
                .background()
                .cornerRadius(16)
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    var titleView: some View {
        if let title = title {
            Text(title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ListSection_Previews: PreviewProvider {
    static var previews: some View {
        ListSection(title: "Title") {
            EmptyView()
        }
    }
}
