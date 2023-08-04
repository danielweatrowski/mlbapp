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
    
    func groupedBackground(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.groupedBackground
        case .dark:
            return current.dark.groupedBackground
        @unknown default:
            return current.light.groupedBackground
        }
    }
    
    func secondaryGroupedBackground(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.secondaryGroupedBackground
        case .dark:
            return current.dark.secondaryGroupedBackground
        @unknown default:
            return current.light.secondaryGroupedBackground
        }
    }
    
    func listRowBackground(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.listRowBackground
        case .dark:
            return current.dark.listRowBackground
        @unknown default:
            return current.light.listRowBackground
        }
    }
    
    func primaryLabel(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.primaryLabel
        case .dark:
            return current.dark.primaryLabel
        @unknown default:
            return current.light.primaryLabel
        }
    }
    
    func secondaryLabel(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.secondaryLabel
        case .dark:
            return current.dark.secondaryLabel
        @unknown default:
            return current.light.secondaryLabel
        }
    }
    
    func tint(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return current.light.tintColor
        case .dark:
            return current.dark.tintColor
        @unknown default:
            return current.light.tintColor
        }
    }
}
