//
//  ThemeColor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/21/23.
//

import SwiftUI


protocol ColorThemeType {
    var background: Color { get }
    var secondaryBackground: Color { get }
    var groupedBackground: Color { get }
    var secondaryGroupedBackground: Color { get }
    var listRowBackground: Color { get }
    var primaryLabel: Color { get }
    var secondaryLabel: Color { get }
    var tintColor: Color { get }
}

struct ColorThemeSet<L: ColorThemeType, D: ColorThemeType> {
    let light: L
    let dark: D
}

enum ColorTheme {
    
    struct DefaultDark: ColorThemeType {
        var background: Color = Color(uiColor: .systemBackground)
        var secondaryBackground: Color = Color(uiColor: .secondarySystemBackground)
        
        var groupedBackground: Color =  Color(uiColor: .systemGroupedBackground)
        var secondaryGroupedBackground: Color = Color(uiColor: .secondarySystemGroupedBackground)
        
        var listRowBackground: Color = Color(uiColor: .secondarySystemBackground)
        
        var primaryLabel: Color = .primary
        var secondaryLabel: Color = .secondary
        var tintColor: Color = .blue
    }
    
    struct DefaultLight: ColorThemeType {
        var background: Color = Color(uiColor: .systemBackground)
        var secondaryBackground: Color = Color(uiColor: .secondarySystemBackground)
        
        var groupedBackground: Color =  Color(uiColor: .systemGroupedBackground)
        var secondaryGroupedBackground: Color = Color(uiColor: .secondarySystemGroupedBackground)
        var listRowBackground: Color = .white

        var primaryLabel: Color = .primary
        var secondaryLabel: Color = .secondary
        var tintColor: Color = .blue
    }
}

struct AvailableColorThemes {
    static let system = ColorThemeSet(light: ColorTheme.DefaultLight(),
                                      dark: ColorTheme.DefaultDark())
}
