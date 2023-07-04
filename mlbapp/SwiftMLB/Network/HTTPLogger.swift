//
//  HTTPLogger.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    private static var displayName: String = "SwiftMLB"
    private static var category = "HTTP"
    
    static let http = Logger(subsystem: subsystem, category: "\(displayName) \(category)")
    
    
    static func log(request: HTTPRequestProtocol) {
        let method = request.method.rawValue
        
        guard let url = request.url else {
            Logger.http.error("Invalid URL")
            return
        }
        
        Logger.http.debug("[Request] \(method, privacy: .public) \(url.absoluteString, privacy: .public)")
        Logger.http.debug("[Request] Body \(request.body?.json ?? "{}", privacy: .public)")
        Logger.http.debug("[Request] Headers \(request.headers?.json ?? "{}", privacy: .public)")
    }
    
    static func log(request: HTTPRequestProtocol, response: URLResponse) {
        guard let url = response.url else {
            Logger.http.error("Invalid URL")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            Logger.http.error("Invalid response for URL \(url.absoluteString), privacy: .public)")
            return
        }
        
        Logger.http.debug("[Response] \(request.method.rawValue, privacy: .public) \(httpResponse.statusCode, privacy: .public) \(url.absoluteString, privacy: .public)")
    }
}
