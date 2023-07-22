//
//  Theme.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/21/23.
//

import SwiftUI

class Theme: ObservableObject {
    
    var current = ColorThemeSet(light: ColorTheme.DefaultLight(),
                                dark: ColorTheme.DefaultDark())
    
    func background(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.background
        case .dark:
            return current.dark.background
        @unknown default:
            return current.light.background
        }
    }
    
    func secondaryBackground(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.secondaryBackground
        case .dark:
            return current.dark.secondaryBackground
        @unknown default:
            return current.light.secondaryBackground
        }
    }
    
}
