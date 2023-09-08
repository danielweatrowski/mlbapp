//
//  GameLogger.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 9/8/23.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    private static var category = "game"
    
    static let game = Logger(subsystem: subsystem, category: category)
}
