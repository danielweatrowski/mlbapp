//
//  BoldedTitleLabel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/15/23.
//

import SwiftUI

struct BoldedTitleLabel<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
    }
}

extension BoldedTitleLabel where Content == Text {
    init(_ title: String, _ text: String) {
        self.init {
            Text(title)
                .bold()
            Text
        }
    }
}
