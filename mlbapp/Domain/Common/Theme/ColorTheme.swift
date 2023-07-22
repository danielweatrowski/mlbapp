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
        var background: Color = Color(uiColor: .systemGroupedBackground)
        
        var secondaryBackground: Color = Color(uiColor: UIColor.secondarySystemBackground)
        
        var primaryLabel: Color = .primary
        
        var secondaryLabel: Color = .secondary
        
        var tintColor: Color = .blue
    }
    
    struct DefaultLight: ColorThemeType {
        var background: Color = Color(uiColor: .systemGroupedBackground)
        
        var secondaryBackground: Color = .white
        
        var primaryLabel: Color = .primary
        
        var secondaryLabel: Color = .secondary
        
        var tintColor: Color = .blue
    }
}
