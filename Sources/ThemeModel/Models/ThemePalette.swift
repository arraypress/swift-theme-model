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

    // Terminal (ANSI)
    //
    // Optional: most themes specify none, and every field must stay decode-safe
    // so palettes written before these existed still round-trip. Read the
    // complete set through `resolvedANSI`, never these directly.

    /// ANSI 0 — black.
    public var ansiBlack: String?
    /// ANSI 1 — red.
    public var ansiRed: String?
    /// ANSI 2 — green.
    public var ansiGreen: String?
    /// ANSI 3 — yellow.
    public var ansiYellow: String?
    /// ANSI 4 — blue.
    public var ansiBlue: String?
    /// ANSI 5 — magenta.
    public var ansiMagenta: String?
    /// ANSI 6 — cyan.
    public var ansiCyan: String?
    /// ANSI 7 — white.
    public var ansiWhite: String?
    /// ANSI 8 — bright black (grey).
    public var ansiBrightBlack: String?
    /// ANSI 9 — bright red.
    public var ansiBrightRed: String?
    /// ANSI 10 — bright green.
    public var ansiBrightGreen: String?
    /// ANSI 11 — bright yellow.
    public var ansiBrightYellow: String?
    /// ANSI 12 — bright blue.
    public var ansiBrightBlue: String?
    /// ANSI 13 — bright magenta.
    public var ansiBrightMagenta: String?
    /// ANSI 14 — bright cyan.
    public var ansiBrightCyan: String?
    /// ANSI 15 — bright white.
    public var ansiBrightWhite: String?

    /// Whether the theme is dark (anything other than `"light"`).
    public var isDark: Bool { appearance.lowercased() != "light" }

    /// The theme's complete 16-color ANSI terminal palette: each slot this theme
    /// specifies, with every gap filled from the curated set matching its
    /// ``isDark`` appearance (``ANSIColors/dark`` / ``ANSIColors/light``).
    ///
    /// A theme that specifies none — every built-in — resolves to the curated
    /// set outright, which is the point: a light theme gets a light-appropriate
    /// palette without anyone hand-authoring 16 colors per theme.
    public var resolvedANSI: ANSIColors {
        let base = ANSIColors.curated(isDark: isDark)
        return ANSIColors(
            black: ansiBlack ?? base.black,
            red: ansiRed ?? base.red,
            green: ansiGreen ?? base.green,
            yellow: ansiYellow ?? base.yellow,
            blue: ansiBlue ?? base.blue,
            magenta: ansiMagenta ?? base.magenta,
            cyan: ansiCyan ?? base.cyan,
            white: ansiWhite ?? base.white,
            brightBlack: ansiBrightBlack ?? base.brightBlack,
            brightRed: ansiBrightRed ?? base.brightRed,
            brightGreen: ansiBrightGreen ?? base.brightGreen,
            brightYellow: ansiBrightYellow ?? base.brightYellow,
            brightBlue: ansiBrightBlue ?? base.brightBlue,
            brightMagenta: ansiBrightMagenta ?? base.brightMagenta,
            brightCyan: ansiBrightCyan ?? base.brightCyan,
            brightWhite: ansiBrightWhite ?? base.brightWhite)
    }

    /// Memberwise initializer — every editor role is required; there are no
    /// derived defaults, so a palette is always fully specified. The ANSI
    /// terminal colors are the exception: they default to `nil` (meaning "use
    /// the curated set for this appearance" — see ``resolvedANSI``).
    public init(
        name: String, appearance: String,
        background: String, foreground: String, cursor: String, selection: String,
        comment: String, string: String, keyword: String, type: String, number: String,
        function: String, variable: String, property: String,
        accent: String, sidebarBackground: String, sidebarText: String,
        tabBarBackground: String, tabText: String, tabActiveText: String, border: String,
        gutterBackground: String, gutterText: String, gutterActiveText: String,
        statusBackground: String, statusText: String,
        ansiBlack: String? = nil, ansiRed: String? = nil, ansiGreen: String? = nil,
        ansiYellow: String? = nil, ansiBlue: String? = nil, ansiMagenta: String? = nil,
        ansiCyan: String? = nil, ansiWhite: String? = nil,
        ansiBrightBlack: String? = nil, ansiBrightRed: String? = nil,
        ansiBrightGreen: String? = nil, ansiBrightYellow: String? = nil,
        ansiBrightBlue: String? = nil, ansiBrightMagenta: String? = nil,
        ansiBrightCyan: String? = nil, ansiBrightWhite: String? = nil
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
        self.ansiBlack = ansiBlack; self.ansiRed = ansiRed
        self.ansiGreen = ansiGreen; self.ansiYellow = ansiYellow
        self.ansiBlue = ansiBlue; self.ansiMagenta = ansiMagenta
        self.ansiCyan = ansiCyan; self.ansiWhite = ansiWhite
        self.ansiBrightBlack = ansiBrightBlack; self.ansiBrightRed = ansiBrightRed
        self.ansiBrightGreen = ansiBrightGreen; self.ansiBrightYellow = ansiBrightYellow
        self.ansiBrightBlue = ansiBrightBlue; self.ansiBrightMagenta = ansiBrightMagenta
        self.ansiBrightCyan = ansiBrightCyan; self.ansiBrightWhite = ansiBrightWhite
    }
}
