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
    private static var displayName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    private static var category = "http"
    
    static let http = Logger(subsystem: subsystem, category: "\(displayName) \(category)")
    
    
    static func log(request: HTTPRequestProtocol) {
        let method = request.method.rawValue
        
        guard let url = request.url else {
            Logger.http.error("Invalid URL")
            return
        }
        
        Logger.http.debug("[\(method, privacy: .public)] URL \(url.absoluteString, privacy: .public)")
        Logger.http.debug("[\(method, privacy: .public)] Body \(request.body?.json ?? "{}", privacy: .public)")
        Logger.http.debug("[\(method, privacy: .public)] Headers \(request.headers?.json ?? "{}", privacy: .public)")
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
        
        Logger.http.debug("[\(request.method.rawValue, privacy: .public)] \(httpResponse.statusCode, privacy: .public) \(url.absoluteString, privacy: .public)")
    }
}
