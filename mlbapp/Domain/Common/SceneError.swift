//
//  SceneError.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import SwiftUI

struct SceneError {
    var didError: Bool = false
    var errorTitle: String = ""
    var errorDescription: String = ""
    
    mutating func present() {
        self.didError = true
    }
    
    init(errorDescription: String, file: String = #file, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent

        self.errorTitle = "Error: \(fileName):\(line)"
        self.errorDescription = errorDescription
    }
    
    init() {
        didError = false
        errorTitle = ""
        errorDescription = ""
    }
}

extension View {
    func withSceneError(_ sceneError: Binding<SceneError>) -> some View {
        self
            .alert(sceneError.errorTitle.wrappedValue, isPresented: sceneError.didError, actions: {
                
            }, message: {
                Text(sceneError.errorDescription.wrappedValue)
            })
    }
}

protocol SceneErrorPresentable {
    func presentSceneError(_ sceneError: SceneError)
}
