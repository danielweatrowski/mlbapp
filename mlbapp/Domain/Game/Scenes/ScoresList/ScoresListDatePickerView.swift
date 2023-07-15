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
        VStack(spacing: 0) {
            //Divider()
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
                .frame(maxWidth: .infinity)
                Divider()
                Button(action: {
                    didTapNextDate?()
                }, label: {
                    Image(systemName: "chevron.right")
                })
                .frame(width: 25, height: 25)
                
            }
            .frame(height: 40)
            .padding(.horizontal)
            .background(.bar)
        }
    }
}
