//
//  ThemeViewModifiers.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/21/23.
//

import SwiftUI


extension View {
    func applyThemeBackground() -> some View {
        modifier(ThemeBackground())
    }
    
    func applyThemeSecondaryBackround() -> some View {
        modifier(ThemeSecondaryBackground())
    }
    
    func groupedBackground() -> some View {
        modifier(ThemeGroupedBackground())
    }
    
    func secondaryGroupedBackground() -> some View {
        modifier(ThemeSecondaryBackground())
    }
    
    func gridItemBackground() -> some View {
        modifier(ThemeGridItemBackground())
    }
    
    func listRowBackground() -> some View {
        modifier(ThemeListRowBackground())
    }
    
    func primaryForeground() -> some View {
        modifier(ThemePrimaryLabelForeground())
    }
    
    func secondaryForeground() -> some View {
        modifier(ThemeSecondaryLabelForeground())
    }
    
    func tintForeground() -> some View {
        modifier(ThemeTintForeground())
    }
}


struct ThemeBackground: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.background(for: colorScheme))
    }
}

struct ThemeSecondaryBackground: ViewModifier {
    
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.secondaryBackground(for: colorScheme))
    }
}

struct ThemeGroupedBackground: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.groupedBackground(for: colorScheme))
    }
}

struct ThemeListRowBackground: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .listRowBackground(theme.listRowBackground(for: colorScheme))
    }
}

struct ThemeGridItemBackground: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.listRowBackground(for: colorScheme))
    }
}

struct ThemeSecondaryGroupedBackground: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .background(theme.secondaryGroupedBackground(for: colorScheme))
    }
}

struct ThemePrimaryLabelForeground: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(theme.primaryLabel(for: colorScheme))
    }
}

struct ThemeSecondaryLabelForeground: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(theme.secondaryLabel(for: colorScheme))
    }
}

struct ThemeTintForeground: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(theme.tint(for: colorScheme))
    }
}
