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

    /// The editor's background color.
    public var background: String
    /// The default text color.
    public var foreground: String
    /// The insertion-point (caret) color.
    public var cursor: String
    /// The selected-text background color.
    public var selection: String

    // Syntax

    /// Comments.
    public var comment: String
    /// String literals.
    public var string: String
    /// Language keywords (`if`, `func`, `return`, …).
    public var keyword: String
    /// Type names (classes, structs, enums).
    public var type: String
    /// Numeric literals and constants.
    public var number: String
    /// Function and method names.
    public var function: String
    /// Variable names.
    public var variable: String
    /// Member/property accesses and object keys.
    public var property: String

    // Accents / chrome

    /// The theme's accent color (buttons, highlights, active indicators).
    public var accent: String
    /// The sidebar / file-tree background.
    public var sidebarBackground: String
    /// The sidebar / file-tree text color.
    public var sidebarText: String
    /// The tab-bar strip background.
    public var tabBarBackground: String
    /// Inactive tab title text.
    public var tabText: String
    /// Active (selected) tab title text.
    public var tabActiveText: String
    /// Divider/border color between panes and panels.
    public var border: String
    /// The line-number gutter background.
    public var gutterBackground: String
    /// Line numbers for inactive lines.
    public var gutterText: String
    /// The line number of the line the cursor is on.
    public var gutterActiveText: String
    /// The status-bar background.
    public var statusBackground: String
    /// The status-bar text color.
    public var statusText: String

    /// Whether the theme is dark (anything other than `"light"`).
    public var isDark: Bool { appearance.lowercased() != "light" }

    /// Memberwise initializer — every role is required; there are no derived
    /// defaults, so a palette is always fully specified.
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
