//
//  ScoresListHeaderView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/26/23.
//

import SwiftUI
import UIKit

struct ScoresListDatePickerView: View {
    @Binding var selectedDate: Date
    
    var didTapDate: (() -> ())?
    var didTapNextDate: (() -> ())?
    var didTapPreviousDate: (() -> ())?
    
    @ViewBuilder
    private var dateText: some View {
        Calendar.current.isDateInToday(selectedDate)
        ? Text("Today")
        :                 Text(selectedDate, style: .date)

        
    }
    
    var body: some View {
        HStack {
            Button(action: {
                didTapPreviousDate?()
            }, label: {
                Image(systemName: "chevron.left")
            })
            .frame(width: 25, height: 25)
            
            Divider()
            Button(action: {
                didTapDate?()
            }, label: {
                dateText
            })
            .frame(width: 120)
            Divider()
            Button(action: {
                didTapNextDate?()
            }, label: {
                Image(systemName: "chevron.right")
            })
            .frame(width: 25, height: 25)

        }
        .frame(height: 46)
        .padding(.horizontal)
        .background(.thickMaterial)
        .cornerRadius(16)
    }
}
