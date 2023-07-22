//
//  ThemeViewModifiers.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/21/23.
//

import SwiftUI

extension View {
    func applyThemeBackground(_ theme: Theme) -> some View {
        modifier(ThemeBackground(theme: theme))
    }
    
    func applyThemeSecondaryBackround(_ theme: Theme) -> some View {
        modifier(ThemeSecondaryBackground(theme: theme))

    }
}


struct ThemeBackground: ViewModifier {
    
    @Environment(\EnvironmentValues.colorScheme) var colorScheme

    var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.background(for: colorScheme))
    }
}

struct ThemeSecondaryBackground: ViewModifier {
    
    @Environment(\EnvironmentValues.colorScheme) var colorScheme

    var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.secondaryBackground(for: colorScheme))
    }
}
