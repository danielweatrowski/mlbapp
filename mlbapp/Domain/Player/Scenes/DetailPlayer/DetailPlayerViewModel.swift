//
//  DetailPlayerViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import Foundation

class DetailPlayerViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var number: String = ""
    @Published var nickname: String = ""
    @Published var headShotURL: URL?
    @Published var teamColorAsHex: String = ""
}
