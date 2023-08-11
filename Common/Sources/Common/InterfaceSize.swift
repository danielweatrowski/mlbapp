//
//  InterfaceSize.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 2/3/23.
//

import Foundation
import SwiftUI


public struct InterfaceSize {
    
    public init(horizontalSizeClass: UserInterfaceSizeClass? = nil, verticalSizeClass: UserInterfaceSizeClass? = nil) {
        self.horizontalSizeClass = horizontalSizeClass
        self.verticalSizeClass = verticalSizeClass
    }
    
    public var horizontalSizeClass: UserInterfaceSizeClass?
    public var verticalSizeClass: UserInterfaceSizeClass?
    
    public var horizontallyConstrained: Bool {
        return horizontalSizeClass == .compact
    }
    
    public var horizontallyRelaxed: Bool {
        return horizontalSizeClass == .regular
    }
    
    public var verticallyConstrained: Bool  {
        return verticalSizeClass == .compact
    }
    
    public var verticallyRelaxed: Bool {
        return verticalSizeClass == .regular
    }
    
    public var relaxed: Bool {
        return verticallyRelaxed && horizontallyConstrained
    }
    
    public var constrained: Bool {
        return verticallyConstrained && horizontallyConstrained
    }
    
    public var portrait: Bool {
        return verticallyRelaxed && horizontallyConstrained
    }
    
    public var landscape: Bool {
        return verticallyConstrained && horizontallyRelaxed
    }
}
