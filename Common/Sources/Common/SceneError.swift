//
//  SceneError.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import SwiftUI

public struct SceneError {
    var didError: Bool = false
    var errorTitle: String = ""
    var errorDescription: String = ""
    
    public mutating func presentAlert(_ sceneError: SceneError) {
        self.errorTitle = sceneError.errorTitle
        self.errorDescription = sceneError.errorDescription
        self.didError = true
    }
    
    public mutating func present() {
        self.didError = true
    }
    
    public init(errorDescription: String, file: String = #file, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent

        self.errorTitle = "Error: \(fileName):\(line)"
        self.errorDescription = errorDescription
    }
    
    public init() {
        didError = false
        errorTitle = ""
        errorDescription = ""
    }
}

public extension View {
    func withSceneError(_ sceneError: Binding<SceneError>) -> some View {
        self
            .alert(sceneError.errorTitle.wrappedValue, isPresented: sceneError.didError, actions: {
                
            }, message: {
                Text(sceneError.errorDescription.wrappedValue)
            })
    }
}

public protocol SceneErrorPresentable {
    func presentSceneError(_ sceneError: SceneError)
}
