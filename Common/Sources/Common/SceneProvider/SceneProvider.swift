//
//  SceneProvider.swift
//  
//
//  Created by Daniel Weatrowski on 8/14/23.
//

import Foundation

@MainActor
public class SceneProvider: ObservableObject {
    
    @Published public var path: [AppScene] = []
    @Published public var presentedSheet: AppScene?
    
    public init() {}

    public func push(scene: AppScene) {
        path.append(scene)
    }
    
    public func present(scene: AppScene) {
        presentedSheet = scene
    }
}
