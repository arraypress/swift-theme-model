//
//  VSCodeThemeImporter.swift
//  SwiftThemeModel
//
//  Maps a VS Code color theme onto a `ThemePalette`. Tolerant of JSONC (comments
//  and trailing commas) since many real-world theme files are JSONC.
//
//  Created by David Sherlock on 7/9/26.
//

import Foundation

/// Imports a VS Code color theme (its `colors` UI keys + `tokenColors` TextMate
/// scopes) into a ``ThemePalette``.
///
/// Best-effort: missing keys fall back sensibly, `#RGB`/`#RGBA` shorthand is
/// expanded, and 8-digit `#RRGGBBAA` values are trimmed to `#RRGGBB`. Input may be
/// **JSONC** (with `//` / `/* */` comments and trailing commas) — many published
/// themes are — and is sanitized before parsing.
///
/// The 16 `terminal.ansi*` keys are imported when present and left `nil`
/// otherwise, so a theme without them resolves to a curated set matching its
/// appearance (see ``ThemePalette/resolvedANSI``).
public enum VSCodeThemeImporter {

    /// Parses a VS Code theme from raw file `data`.
    /// - Parameter fallbackName: used when the theme JSON has no `name`.
    /// - Returns: a ``ThemePalette``, or `nil` if the data isn't a JSON object.
    public static func palette(from data: Data, fallbackName: String) -> ThemePalette? {
        let sanitized = Data(sanitizeJSONC(String(decoding: data, as: UTF8.self)).utf8)
        guard let json = try? JSONSerialization.jsonObject(with: sanitized) as? [String: Any] else { return nil }
        let colors = json["colors"] as? [String: Any] ?? [:]
        let tokens = json["tokenColors"] as? [[String: Any]] ?? []

        func ui(_ key: String, _ fallback: String) -> String { hex6(colors[key] as? String) ?? fallback }

        // Terminal ANSI colors: passed through as optionals (no fallback) — a
        // theme that omits them resolves to the curated set for its appearance
        // via `ThemePalette.resolvedANSI`, rather than being pinned here.
        func ansi(_ key: String) -> String? { hex6(colors["terminal.ansi" + key] as? String) }

        // Pre-extract each token rule's scopes + foreground once (rules without a
        // usable foreground are ignored, matching the old behavior).
        let rules: [(scopes: [String], fg: String)] = tokens.compactMap { t in
            let scopes: [String]
            if let s = t["scope"] as? String {
                scopes = s.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            } else if let arr = t["scope"] as? [String] {
                scopes = arr
            } else { return nil }
            guard let settings = t["settings"] as? [String: Any],
                  let fg = hex6(settings["foreground"] as? String) else { return nil }
            return (scopes, fg)
        }

        func scope(_ needles: [String], _ fallback: String) -> String {
            // Needles are ordered specific → generic; honor that ordering. Within a
            // needle, an exact scope match beats a prefix match, and the LAST
            // matching rule wins (approximating VS Code's later-rule-wins).
            for needle in needles {
                if let fg = rules.last(where: { $0.scopes.contains(needle) })?.fg { return fg }
                if let fg = rules.last(where: { $0.scopes.contains { $0.hasPrefix(needle + ".") } })?.fg { return fg }
            }
            return fallback
        }

        let bg = ui("editor.background", "#1E1E1E")
        let fg = ui("editor.foreground", "#D4D4D4")
        let keyword = scope(["keyword", "storage"], "#C586C0")

        // Many VS Code theme JSONs omit `type` (it lives in the extension manifest,
        // not the color-theme file), so fall back to the background's luminance.
        // Known types: light/dark plus the high-contrast pair (hcLight is LIGHT);
        // anything unrecognized also falls back to luminance.
        let appearance: String = {
            switch (json["type"] as? String)?.lowercased() {
            case "light", "hclight", "hc-light": return "light"
            case "dark", "hc", "hcdark", "hc-dark", "hc-black": return "dark"
            default: return isLight(bg) ? "light" : "dark"
            }
        }()

        return ThemePalette(
            name: (json["name"] as? String) ?? fallbackName,
            appearance: appearance,
            background: bg,
            foreground: fg,
            cursor: ui("editorCursor.foreground", fg),
            selection: ui("editor.selectionBackground", "#264F78"),
            comment: scope(["comment"], "#6A9955"),
            string: scope(["string"], "#CE9178"),
            keyword: keyword,
            type: scope(["entity.name.type", "support.type", "storage.type", "entity.name.class"], "#4EC9B0"),
            number: scope(["constant.numeric", "constant"], "#B5CEA8"),
            function: scope(["entity.name.function", "support.function"], "#DCDCAA"),
            variable: scope(["variable"], fg),
            property: scope(["variable.other.property", "support.variable", "meta.object-literal.key"], scope(["variable"], fg)),
            accent: keyword,
            sidebarBackground: ui("sideBar.background", bg),
            sidebarText: ui("sideBar.foreground", fg),
            tabBarBackground: ui("editorGroupHeader.tabsBackground", bg),
            tabText: ui("tab.inactiveForeground", fg),
            tabActiveText: ui("tab.activeForeground", fg),
            border: ui("editorGroup.border", ui("panel.border", bg)),
            gutterBackground: bg,
            gutterText: ui("editorLineNumber.foreground", "#858585"),
            gutterActiveText: ui("editorLineNumber.activeForeground", fg),
            statusBackground: ui("statusBar.background", bg),
            statusText: ui("statusBar.foreground", fg),
            ansiBlack: ansi("Black"), ansiRed: ansi("Red"),
            ansiGreen: ansi("Green"), ansiYellow: ansi("Yellow"),
            ansiBlue: ansi("Blue"), ansiMagenta: ansi("Magenta"),
            ansiCyan: ansi("Cyan"), ansiWhite: ansi("White"),
            ansiBrightBlack: ansi("BrightBlack"), ansiBrightRed: ansi("BrightRed"),
            ansiBrightGreen: ansi("BrightGreen"), ansiBrightYellow: ansi("BrightYellow"),
            ansiBrightBlue: ansi("BrightBlue"), ansiBrightMagenta: ansi("BrightMagenta"),
            ansiBrightCyan: ansi("BrightCyan"), ansiBrightWhite: ansi("BrightWhite"))
    }

    /// Whether a `#RRGGBB` color reads as "light" (perceived luminance), used to
    /// infer a theme's appearance when its `type` field is absent.
    static func isLight(_ hex: String) -> Bool {
        let h = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        guard h.count == 6, let v = Int(h, radix: 16) else { return false }
        let r = Double((v >> 16) & 0xFF), g = Double((v >> 8) & 0xFF), b = Double(v & 0xFF)
        return (0.299 * r + 0.587 * g + 0.114 * b) > 140
    }

    /// Normalizes a hex color string to `#RRGGBB`, expanding `#RGB`/`#RGBA`
    /// shorthand and dropping any 2-digit alpha. Returns `nil` if not a hex color.
    static func hex6(_ s: String?) -> String? {
        guard var s = s, s.hasPrefix("#"),
              !s.dropFirst().isEmpty,
              s.dropFirst().allSatisfy({ $0.isASCII && $0.isHexDigit }) else { return nil }
        if s.count == 4 || s.count == 5 {   // expand #RGB / #RGBA shorthand
            s = "#" + s.dropFirst().map { "\($0)\($0)" }.joined()
        }
        if s.count >= 7 { s = String(s.prefix(7)) }   // #RRGGBB, drop any alpha
        return s.count == 7 ? s : nil
    }

    /// Strips `//` and `/* */` comments and trailing commas (JSONC → JSON),
    /// respecting string literals so real-world theme files parse.
    static func sanitizeJSONC(_ s: String) -> String {
        let a = Array(s)
        var out: [Character] = []; out.reserveCapacity(a.count)
        var i = 0, inStr = false, esc = false
        while i < a.count {
            let c = a[i]
            if inStr {
                out.append(c)
                if esc { esc = false } else if c == "\\" { esc = true } else if c == "\"" { inStr = false }
                i += 1; continue
            }
            if c == "\"" { inStr = true; out.append(c); i += 1; continue }
            if c == "/", i + 1 < a.count, a[i + 1] == "/" {                 // line comment
                while i < a.count, a[i] != "\n" { i += 1 }
                continue
            }
            if c == "/", i + 1 < a.count, a[i + 1] == "*" {                 // block comment
                i += 2
                while i + 1 < a.count, !(a[i] == "*" && a[i + 1] == "/") { i += 1 }
                i = min(i + 2, a.count)
                continue
            }
            out.append(c); i += 1
        }
        // second pass: drop trailing commas (a `,` before `}` or `]`)
        var res: [Character] = []; res.reserveCapacity(out.count)
        i = 0; inStr = false; esc = false
        while i < out.count {
            let c = out[i]
            if inStr {
                res.append(c)
                if esc { esc = false } else if c == "\\" { esc = true } else if c == "\"" { inStr = false }
                i += 1; continue
            }
            if c == "\"" { inStr = true; res.append(c); i += 1; continue }
            if c == "," {
                var j = i + 1
                while j < out.count, out[j] == " " || out[j] == "\n" || out[j] == "\t" || out[j] == "\r" { j += 1 }
                if j < out.count, out[j] == "}" || out[j] == "]" { i += 1; continue }
            }
            res.append(c); i += 1
        }
        return String(res)
    }
}
