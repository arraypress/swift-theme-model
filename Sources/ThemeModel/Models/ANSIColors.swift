//
//  ANSIColors.swift
//  SwiftThemeModel
//
//  The 16 ANSI terminal colors, plus curated dark/light defaults for themes that
//  don't specify their own.
//
//  Created by David Sherlock on 7/16/26.
//

import Foundation

/// The 16 ANSI terminal colors as `#RRGGBB` hex strings, in the standard order
/// (8 normal + 8 bright).
///
/// A ``ThemePalette`` stores these as optional fields — most themes specify none
/// — so use ``ThemePalette/resolvedANSI`` to get a complete set with any gaps
/// filled from ``dark`` / ``light``.
///
/// ```swift
/// let ansi = palette.resolvedANSI
/// terminalView.installColors(ansi.indexed.map(MyColor.init(hex:)))
/// ```
public struct ANSIColors: Equatable, Sendable {

    /// ANSI 0 — black.
    public var black: String
    /// ANSI 1 — red.
    public var red: String
    /// ANSI 2 — green.
    public var green: String
    /// ANSI 3 — yellow.
    public var yellow: String
    /// ANSI 4 — blue.
    public var blue: String
    /// ANSI 5 — magenta.
    public var magenta: String
    /// ANSI 6 — cyan.
    public var cyan: String
    /// ANSI 7 — white.
    public var white: String

    /// ANSI 8 — bright black (grey).
    public var brightBlack: String
    /// ANSI 9 — bright red.
    public var brightRed: String
    /// ANSI 10 — bright green.
    public var brightGreen: String
    /// ANSI 11 — bright yellow.
    public var brightYellow: String
    /// ANSI 12 — bright blue.
    public var brightBlue: String
    /// ANSI 13 — bright magenta.
    public var brightMagenta: String
    /// ANSI 14 — bright cyan.
    public var brightCyan: String
    /// ANSI 15 — bright white.
    public var brightWhite: String

    /// Memberwise initializer — all 16 slots are required; a partially specified
    /// set is expressed on ``ThemePalette`` as optional fields instead.
    public init(
        black: String, red: String, green: String, yellow: String,
        blue: String, magenta: String, cyan: String, white: String,
        brightBlack: String, brightRed: String, brightGreen: String, brightYellow: String,
        brightBlue: String, brightMagenta: String, brightCyan: String, brightWhite: String
    ) {
        self.black = black; self.red = red; self.green = green; self.yellow = yellow
        self.blue = blue; self.magenta = magenta; self.cyan = cyan; self.white = white
        self.brightBlack = brightBlack; self.brightRed = brightRed
        self.brightGreen = brightGreen; self.brightYellow = brightYellow
        self.brightBlue = brightBlue; self.brightMagenta = brightMagenta
        self.brightCyan = brightCyan; self.brightWhite = brightWhite
    }

    /// The 16 colors in ANSI index order (0…15) — the order terminal emulators
    /// expect when installing a palette.
    public var indexed: [String] {
        [black, red, green, yellow, blue, magenta, cyan, white,
         brightBlack, brightRed, brightGreen, brightYellow,
         brightBlue, brightMagenta, brightCyan, brightWhite]
    }

    /// A curated set tuned for dark backgrounds (VS Code's default dark terminal
    /// palette). Used when a dark theme supplies no ANSI colors of its own.
    public static let dark = ANSIColors(
        black: "#000000", red: "#CD3131", green: "#0DBC79", yellow: "#E5E510",
        blue: "#2472C8", magenta: "#BC3FBC", cyan: "#11A8CD", white: "#E5E5E5",
        brightBlack: "#666666", brightRed: "#F14C4C", brightGreen: "#23D18B",
        brightYellow: "#F5F543", brightBlue: "#3B8EEA", brightMagenta: "#D670D6",
        brightCyan: "#29B8DB", brightWhite: "#FFFFFF")

    /// A curated set tuned for light backgrounds (VS Code's default light
    /// terminal palette). Used when a light theme supplies no ANSI colors of its
    /// own.
    ///
    /// Deliberately not a lightened ``dark``: on a light background the colors
    /// must be *darker* to stay readable, and ANSI "white" has to render as a
    /// dark grey or white-on-white text disappears.
    public static let light = ANSIColors(
        black: "#000000", red: "#CD3131", green: "#00BC00", yellow: "#949800",
        blue: "#0451A5", magenta: "#BC05BC", cyan: "#0598BC", white: "#555555",
        brightBlack: "#666666", brightRed: "#CD3131", brightGreen: "#14CE14",
        brightYellow: "#B5BA00", brightBlue: "#0451A5", brightMagenta: "#BC05BC",
        brightCyan: "#0598BC", brightWhite: "#A5A5A5")

    /// The curated set matching a theme's appearance — ``dark`` or ``light``.
    public static func curated(isDark: Bool) -> ANSIColors { isDark ? .dark : .light }
}
