//
//  ThemePalette.swift
//  SwiftThemeModel
//
//  A flat, hex-based editor color theme. Small, human-editable, Codable — the
//  on-disk / serialization format for an editor's colors.
//
//  Created by David Sherlock on 7/9/26.
//

import Foundation

/// A flat set of hex colors describing an editor theme.
///
/// Only core roles are stored; chrome roles (gutter, tabs, status bar) are
/// included so a UI can render fully without deriving them.
public struct ThemePalette: Codable, Equatable, Sendable {

    /// The theme's display name.
    public var name: String
    /// `"dark"` or `"light"`.
    public var appearance: String

    // Editor surface
    public var background: String
    public var foreground: String
    public var cursor: String
    public var selection: String

    // Syntax
    public var comment: String
    public var string: String
    public var keyword: String
    public var type: String
    public var number: String
    public var function: String
    public var variable: String
    public var property: String

    // Accents / chrome
    public var accent: String
    public var sidebarBackground: String
    public var sidebarText: String
    public var tabBarBackground: String
    public var tabText: String
    public var tabActiveText: String
    public var border: String
    public var gutterBackground: String
    public var gutterText: String
    public var gutterActiveText: String
    public var statusBackground: String
    public var statusText: String

    /// Whether the theme is dark (anything other than `"light"`).
    public var isDark: Bool { appearance.lowercased() != "light" }

    public init(
        name: String, appearance: String,
        background: String, foreground: String, cursor: String, selection: String,
        comment: String, string: String, keyword: String, type: String, number: String,
        function: String, variable: String, property: String,
        accent: String, sidebarBackground: String, sidebarText: String,
        tabBarBackground: String, tabText: String, tabActiveText: String, border: String,
        gutterBackground: String, gutterText: String, gutterActiveText: String,
        statusBackground: String, statusText: String
    ) {
        self.name = name; self.appearance = appearance
        self.background = background; self.foreground = foreground
        self.cursor = cursor; self.selection = selection
        self.comment = comment; self.string = string; self.keyword = keyword
        self.type = type; self.number = number; self.function = function
        self.variable = variable; self.property = property
        self.accent = accent; self.sidebarBackground = sidebarBackground
        self.sidebarText = sidebarText; self.tabBarBackground = tabBarBackground
        self.tabText = tabText; self.tabActiveText = tabActiveText; self.border = border
        self.gutterBackground = gutterBackground; self.gutterText = gutterText
        self.gutterActiveText = gutterActiveText
        self.statusBackground = statusBackground; self.statusText = statusText
    }
}
