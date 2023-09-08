//
//  File.swift
//  
//
//  Created by Daniel Weatrowski on 9/8/23.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    private static var category = "SwiftMLB"
    
    static let swiftmlb = Logger(subsystem: subsystem, category: "\(category)")
    
}
