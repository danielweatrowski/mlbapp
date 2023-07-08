//
//  ToolbarPickerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import SwiftUI

struct ToolbarPickerView<S: StringProtocol>: View {
    
    let title: S
    
    let item0Title: String
    let item1Title: String
    
    @Binding var selection: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Picker(title, selection: $selection) {
                Text(item0Title).tag(0)
                Text(item1Title).tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .frame(height: 40)

        .padding(.vertical, 4)
        .background(.ultraThickMaterial)
        
    }
}

struct ToolbarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarPickerView(title: "", item0Title: "Home", item1Title: "Away", selection: .constant(0))
    }
}
