//
//  Router.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/19/23.
//

import Foundation

enum RouterDestination: Hashable {
    case gameList
}

@MainActor
class Router: ObservableObject {
    @Published public var path: [RouterDestination] = []

}
