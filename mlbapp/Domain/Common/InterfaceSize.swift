//
//  InterfaceSize.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 2/3/23.
//

import Foundation
import SwiftUI


struct InterfaceSize {
    
    var horizontalSizeClass: UserInterfaceSizeClass?
    var verticalSizeClass: UserInterfaceSizeClass?
    
    var horizontallyConstrained: Bool {
        return horizontalSizeClass == .compact
    }
    
    var horizontallyRelaxed: Bool {
        return horizontalSizeClass == .regular
    }
    
    var verticallyConstrained: Bool  {
        return verticalSizeClass == .compact
    }
    
    var verticallyRelaxed: Bool {
        return verticalSizeClass == .regular
    }
    
    var relaxed: Bool {
        return verticallyRelaxed && horizontallyConstrained
    }
    
    var constrained: Bool {
        return verticallyConstrained && horizontallyConstrained
    }
    
    var portrait: Bool {
        return verticallyRelaxed && horizontallyConstrained
    }
    
    var landscape: Bool {
        return verticallyConstrained && horizontallyRelaxed
    }
}
