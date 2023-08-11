//
//  ToolbarPickerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import SwiftUI

public struct ToolbarPickerView<S: StringProtocol>: View {
    
    let title: S
    
    let item0Title: String
    let item1Title: String
    var item2Title: String? = nil
    
    @Binding var selection: Int
    
    public init(title: S, item0Title: String, item1Title: String, item2Title: String? = nil, selection: Binding<Int>) {
        self.title = title
        self.item0Title = item0Title
        self.item1Title = item1Title
        self.item2Title = item2Title
        self._selection = selection
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Picker(title, selection: $selection) {
                Text(item0Title).tag(0)
                Text(item1Title).tag(1)
                if let item2Title = item2Title {
                    Text(item2Title).tag(2)
                }
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
