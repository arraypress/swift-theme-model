//
//  ThemeModelTests.swift
//  Tests for SwiftThemeModel — validated against real VS Code theme files.
//
//  Created by David Sherlock on 7/9/26.
//

import XCTest
@testable import ThemeModel

final class ThemeModelTests: XCTestCase {

    // Real theme fixtures (VS Code built-ins + community themes). `monokai-jsonc`
    // is a source theme WITH `//` comments (JSONC); the rest are strict JSON.
    private let darkThemes = ["abyss", "kimbie-dark", "monokai", "monokai-jsonc", "nightowl", "onedark"]
    private let lightThemes = ["quietlight", "solarized-light", "winterlight"]
    private var allThemes: [String] { darkThemes + lightThemes }

    private let hexRe = try! NSRegularExpression(pattern: "^#[0-9A-Fa-f]{6}$")

    private func load(_ name: String) throws -> Data {
        let url = try XCTUnwrap(
            Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures"),
            "missing fixture \(name).json")
        return try Data(contentsOf: url)
    }
    private func isHex(_ s: String) -> Bool {
        hexRe.firstMatch(in: s, range: NSRange(s.startIndex..., in: s)) != nil
    }

    // MARK: - Every real theme imports

    func testAllRealThemesImport() throws {
        for name in allThemes {
            let palette = VSCodeThemeImporter.palette(from: try load(name), fallbackName: name)
            XCTAssertNotNil(palette, "\(name).json failed to import")
        }
    }

    /// The key robustness case: a JSONC theme (with `//` comments) must import —
    /// the old importer using bare JSONSerialization would return nil here.
    func testJSONCThemeWithCommentsImports() throws {
        // The source Monokai is JSONC (has `//` comments) and omits top-level `name`.
        // The old importer (bare JSONSerialization) would return nil here.
        let palette = try XCTUnwrap(VSCodeThemeImporter.palette(from: try load("monokai-jsonc"), fallbackName: "Fallback"))
        XCTAssertTrue(palette.isDark)                                   // has type: "dark"
        XCTAssertEqual(palette.name, "Fallback")                        // no name in file → fallback used
        XCTAssertTrue(isHex(palette.background), "got \(palette.background)")
        XCTAssertEqual(palette.background.uppercased(), "#272822")      // real Monokai editor.background
    }

    func testAppearanceDetection() throws {
        for name in lightThemes {
            let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: try load(name), fallbackName: name))
            XCTAssertFalse(p.isDark, "\(name) should be light")
        }
        for name in darkThemes {
            let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: try load(name), fallbackName: name))
            XCTAssertTrue(p.isDark, "\(name) should be dark")
        }
    }

    /// Every color field of every imported theme is a valid `#RRGGBB` string.
    func testAllImportedColorsAreValidHex() throws {
        for name in allThemes {
            let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: try load(name), fallbackName: name))
            for (label, value) in [
                ("background", p.background), ("foreground", p.foreground), ("cursor", p.cursor),
                ("selection", p.selection), ("comment", p.comment), ("string", p.string),
                ("keyword", p.keyword), ("type", p.type), ("number", p.number),
                ("function", p.function), ("variable", p.variable), ("property", p.property),
                ("accent", p.accent), ("sidebarBackground", p.sidebarBackground),
                ("border", p.border), ("gutterText", p.gutterText), ("statusBackground", p.statusBackground),
            ] {
                XCTAssertTrue(isHex(value), "\(name).\(label) = \(value) is not #RRGGBB")
            }
        }
    }

    // MARK: - hex6 normalization

    func testHex6Normalization() {
        XCTAssertEqual(VSCodeThemeImporter.hex6("#abc"), "#aabbcc")       // #RGB shorthand
        XCTAssertEqual(VSCodeThemeImporter.hex6("#abcd"), "#aabbcc")      // #RGBA shorthand → drop alpha
        XCTAssertEqual(VSCodeThemeImporter.hex6("#123456"), "#123456")    // pass-through
        XCTAssertEqual(VSCodeThemeImporter.hex6("#12345678"), "#123456")  // #RRGGBBAA → trim alpha
        XCTAssertNil(VSCodeThemeImporter.hex6("red"))                     // not hex
        XCTAssertNil(VSCodeThemeImporter.hex6(nil))
    }

    /// Regression: hex6 must reject strings whose payload isn't hex digits —
    /// it used to pass "#GGGGGG" / "#no-way" through as "colors".
    func testHex6RejectsNonHexDigits() {
        XCTAssertNil(VSCodeThemeImporter.hex6("#GGGGGG"))
        XCTAssertNil(VSCodeThemeImporter.hex6("#no-way"))
        XCTAssertNil(VSCodeThemeImporter.hex6("#zzz"))
        XCTAssertNil(VSCodeThemeImporter.hex6("#"))
        XCTAssertNil(VSCodeThemeImporter.hex6("#+2345"))                  // Int(radix:) would accept a sign
        XCTAssertEqual(VSCodeThemeImporter.hex6("#AbCdEf"), "#AbCdEf")    // mixed case still valid
    }

    /// Regression: a non-hex "color" in the theme must engage the fallback chain,
    /// not leak the garbage string into the palette.
    func testImportFallsBackOnNonHexColor() throws {
        let json = ##"{"colors": {"editor.background": "#no-way"}}"##
        let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: Data(json.utf8), fallbackName: "t"))
        XCTAssertEqual(p.background, "#1E1E1E")                           // fallback, not "#no-way"
    }

    // MARK: - Appearance from `type`

    /// Regression: VS Code's "hcLight" (high-contrast light) type was mapped to dark.
    func testHCLightTypeIsLight() throws {
        let json = ##"{"type": "hcLight", "colors": {"editor.background": "#FFFFFF"}}"##
        let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: Data(json.utf8), fallbackName: "t"))
        XCTAssertEqual(p.appearance, "light")
        XCTAssertFalse(p.isDark)
    }

    /// An unrecognized `type` string falls through to the background-luminance heuristic.
    func testUnknownTypeFallsBackToLuminance() throws {
        let json = ##"{"type": "surprise", "colors": {"editor.background": "#FFFFFF"}}"##
        let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: Data(json.utf8), fallbackName: "t"))
        XCTAssertFalse(p.isDark)
    }

    // MARK: - scope() needle priority

    /// Regression: a generic rule earlier in the file (constant.language matching
    /// the "constant" needle by prefix) used to beat a later exact
    /// "constant.numeric" rule; needle order must win over file order.
    func testScopeNeedlePriorityBeatsFileOrder() throws {
        let json = """
        {"tokenColors": [
            {"scope": "constant.language", "settings": {"foreground": "#FF0000"}},
            {"scope": "constant.numeric",  "settings": {"foreground": "#00FF00"}}
        ]}
        """
        let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: Data(json.utf8), fallbackName: "t"))
        XCTAssertEqual(p.number, "#00FF00")
    }

    /// Within one needle tier, the LAST matching rule wins (VS Code's later-rule-wins).
    func testScopeLaterRuleWinsWithinTier() throws {
        let json = """
        {"tokenColors": [
            {"scope": "comment", "settings": {"foreground": "#111111"}},
            {"scope": "comment", "settings": {"foreground": "#222222"}}
        ]}
        """
        let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: Data(json.utf8), fallbackName: "t"))
        XCTAssertEqual(p.comment, "#222222")
    }

    // MARK: - JSONC sanitizer

    func testSanitizeStripsCommentsAndTrailingCommas() {
        let jsonc = """
        {
            // line comment
            "type": "dark",   /* block comment */
            "colors": {
                "editor.background": "#101010",
            },
        }
        """
        let clean = VSCodeThemeImporter.sanitizeJSONC(jsonc)
        let obj = try? JSONSerialization.jsonObject(with: Data(clean.utf8)) as? [String: Any]
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?["type"] as? String, "dark")
    }

    func testSanitizePreservesSlashesInsideStrings() {
        // A `//` inside a string value must NOT be treated as a comment.
        let jsonc = #"{"name": "http://not-a-comment", "x": 1}"#
        let clean = VSCodeThemeImporter.sanitizeJSONC(jsonc)
        let obj = try? JSONSerialization.jsonObject(with: Data(clean.utf8)) as? [String: Any]
        XCTAssertEqual(obj?["name"] as? String, "http://not-a-comment")
    }

    // MARK: - ANSI terminal colors

    /// A theme with no `terminal.*` keys — every built-in, and most real VS Code
    /// themes — must resolve to the curated set for its appearance, not to
    /// nothing (the terminal would render through a palette for the wrong
    /// background).
    func testANSIFallsBackToCuratedSetByAppearance() throws {
        let dark = try XCTUnwrap(VSCodeThemeImporter.palette(
            from: Data(##"{"type": "dark", "colors": {"editor.background": "#101010"}}"##.utf8),
            fallbackName: "d"))
        XCTAssertNil(dark.ansiRed, "no terminal.* key → the stored field stays nil")
        XCTAssertEqual(dark.resolvedANSI, .dark)

        let light = try XCTUnwrap(VSCodeThemeImporter.palette(
            from: Data(##"{"type": "light", "colors": {"editor.background": "#FFFFFF"}}"##.utf8),
            fallbackName: "l"))
        XCTAssertEqual(light.resolvedANSI, .light)

        // The two curated sets must actually differ, or the light fallback is pointless.
        XCTAssertNotEqual(ANSIColors.dark, ANSIColors.light)
        XCTAssertEqual(ANSIColors.curated(isDark: true), .dark)
        XCTAssertEqual(ANSIColors.curated(isDark: false), .light)
    }

    /// Every built-in theme resolves to a full 16 valid hex colors — whether it
    /// declares its own set or falls back to the curated one for its appearance.
    func testBuiltInThemesResolveFullANSIPalette() {
        for theme in BuiltInThemes.all {
            let ansi = theme.resolvedANSI
            XCTAssertEqual(ansi.indexed.count, 16, "\(theme.name) must resolve 16 colors")
            for (i, hex) in ansi.indexed.enumerated() {
                XCTAssertTrue(isHex(hex), "\(theme.name) ANSI \(i) = \(hex) is not #RRGGBB")
            }
            // A theme that declares nothing must land exactly on the curated set
            // for its appearance; one that declares its own must not be
            // overwritten by it.
            if theme.ansiRed == nil {
                XCTAssertEqual(ansi, ANSIColors.curated(isDark: theme.isDark),
                               "\(theme.name) declares no ANSI, so it must resolve to the curated set")
            } else {
                XCTAssertEqual(ansi.red, theme.ansiRed,
                               "\(theme.name) declares ANSI, so its own values must win")
            }
        }
    }

    /// Every real fixture theme resolves 16 valid hex colors, whether it ships
    /// `terminal.*` keys or not.
    func testAllRealThemesResolveValidANSI() throws {
        for name in allThemes {
            let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: try load(name), fallbackName: name))
            let ansi = p.resolvedANSI
            XCTAssertEqual(ansi.indexed.count, 16)
            for (i, hex) in ansi.indexed.enumerated() {
                XCTAssertTrue(isHex(hex), "\(name) ANSI \(i) = \(hex) is not #RRGGBB")
            }
        }
    }

    /// A theme that DOES ship `terminal.ansi*` keys has them imported, with hex
    /// normalization applied and unspecified slots still filled from the curated set.
    func testANSIImportedFromTerminalKeys() throws {
        let json = ##"""
        {"type": "dark", "colors": {
            "editor.background": "#101010",
            "terminal.ansiRed": "#ABC",
            "terminal.ansiGreen": "#00FF0080",
            "terminal.ansiBrightWhite": "#FAFAFA"
        }}
        """##
        let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: Data(json.utf8), fallbackName: "t"))
        XCTAssertEqual(p.ansiRed, "#AABBCC")                  // #RGB shorthand expanded
        XCTAssertEqual(p.ansiGreen, "#00FF00")                // #RRGGBBAA alpha trimmed
        XCTAssertEqual(p.ansiBrightWhite, "#FAFAFA")

        let ansi = p.resolvedANSI
        XCTAssertEqual(ansi.red, "#AABBCC")
        XCTAssertEqual(ansi.brightWhite, "#FAFAFA")
        XCTAssertEqual(ansi.blue, ANSIColors.dark.blue, "unspecified slots keep the curated color")
        XCTAssertEqual(ansi.indexed[1], "#AABBCC", "ANSI index order: 1 is red")
        XCTAssertEqual(ansi.indexed[15], "#FAFAFA", "ANSI index order: 15 is bright white")
    }

    /// A non-hex `terminal.ansi*` value must be rejected into the fallback, not
    /// leaked into the palette (the hex6 contract, applied to ANSI too).
    func testANSIRejectsNonHex() throws {
        let json = ##"{"type": "dark", "colors": {"terminal.ansiRed": "red"}}"##
        let p = try XCTUnwrap(VSCodeThemeImporter.palette(from: Data(json.utf8), fallbackName: "t"))
        XCTAssertNil(p.ansiRed)
        XCTAssertEqual(p.resolvedANSI.red, ANSIColors.dark.red)
    }

    /// Decode-safety: palette JSON written before ANSI existed must still decode
    /// unchanged, and a nil ANSI field must not be encoded.
    func testPaletteJSONWithoutANSIStillDecodes() throws {
        let data = try JSONEncoder().encode(BuiltInThemes.monokai)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
        XCTAssertNil(json["ansiRed"], "a nil ANSI field must not be encoded")

        let decoded = try JSONDecoder().decode(ThemePalette.self, from: data)
        XCTAssertEqual(decoded, BuiltInThemes.monokai)
        XCTAssertNil(decoded.ansiRed)
        XCTAssertEqual(decoded.resolvedANSI, .dark)
    }

    /// A stored theme that DOES carry ANSI fields round-trips them.
    func testPaletteANSIRoundTrips() throws {
        var p = BuiltInThemes.solarizedLight
        p.ansiRed = "#DC322F"
        let decoded = try JSONDecoder().decode(
            ThemePalette.self, from: try JSONEncoder().encode(p))
        XCTAssertEqual(decoded.ansiRed, "#DC322F")
        XCTAssertEqual(decoded.resolvedANSI.red, "#DC322F")
        XCTAssertEqual(decoded.resolvedANSI.blue, ANSIColors.light.blue)
    }

    // MARK: - Built-in themes

    func testBuiltInThemesAreValid() {
        XCTAssertEqual(BuiltInThemes.monokai.name, "Monokai")
        XCTAssertTrue(BuiltInThemes.monokai.isDark)
        XCTAssertTrue(isHex(BuiltInThemes.monokai.background))
        XCTAssertFalse(BuiltInThemes.solarizedLight.isDark)
    }

    // MARK: - Colour math helpers (WCAG 2.1 + an achromaticity proxy)

    private func rgb(_ hex: String) -> (r: Double, g: Double, b: Double) {
        let h = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        let v = Int(h, radix: 16) ?? 0
        return (Double((v >> 16) & 0xFF), Double((v >> 8) & 0xFF), Double(v & 0xFF))
    }

    /// WCAG relative luminance.
    private func luminance(_ hex: String) -> Double {
        let c = rgb(hex)
        func lin(_ v: Double) -> Double {
            let s = v / 255
            return s <= 0.03928 ? s / 12.92 : pow((s + 0.055) / 1.055, 2.4)
        }
        return 0.2126 * lin(c.r) + 0.7152 * lin(c.g) + 0.0722 * lin(c.b)
    }

    /// WCAG 2.1 contrast ratio (1…21).
    private func contrast(_ a: String, _ b: String) -> Double {
        let (x, y) = (luminance(a), luminance(b))
        return (max(x, y) + 0.05) / (min(x, y) + 0.05)
    }

    /// `max(R,G,B) - min(R,G,B)` — 0 for a true grey, large for a saturated
    /// colour. A cheap, exact stand-in for chroma that needs no Lab conversion.
    private func spread(_ hex: String) -> Double {
        let c = rgb(hex)
        return max(c.r, c.g, c.b) - min(c.r, c.g, c.b)
    }

    private func syntaxRoles(_ p: ThemePalette) -> [(String, String)] {
        [("comment", p.comment), ("string", p.string), ("keyword", p.keyword),
         ("type", p.type), ("number", p.number), ("function", p.function),
         ("variable", p.variable), ("property", p.property),
         ("foreground", p.foreground)]
    }

    // MARK: - Built-in inventory

    func testBuiltInThemeInventory() {
        XCTAssertEqual(BuiltInThemes.all.count, 24)
        let light = BuiltInThemes.all.filter { !$0.isDark }
        let dark = BuiltInThemes.all.filter { $0.isDark }
        XCTAssertEqual(dark.count, 18)   // + Claude
        // The point of the light additions: daylight work needs real options.
        XCTAssertEqual(light.count, 6)
        XCTAssertEqual(light.map(\.name).sorted(),
                       ["Catppuccin Latte", "Everforest Light", "GitHub Light",
                        "Rosé Pine Dawn", "Solarized Light", "Windshield Light"])
    }

    /// Themes are persisted and looked up BY NAME, so a duplicate name would
    /// make one theme unselectable.
    func testBuiltInThemeNamesAreUnique() {
        let names = BuiltInThemes.all.map(\.name)
        XCTAssertEqual(Set(names).count, names.count)
    }

    /// Every colour of every built-in — including all 16 resolved ANSI slots —
    /// is a valid `#RRGGBB` string.
    func testEveryBuiltInColorIsValidHex() {
        for t in BuiltInThemes.all {
            for (label, value) in syntaxRoles(t) + [
                ("background", t.background), ("cursor", t.cursor), ("selection", t.selection),
                ("accent", t.accent), ("sidebarBackground", t.sidebarBackground),
                ("sidebarText", t.sidebarText), ("tabBarBackground", t.tabBarBackground),
                ("tabText", t.tabText), ("tabActiveText", t.tabActiveText), ("border", t.border),
                ("gutterBackground", t.gutterBackground), ("gutterText", t.gutterText),
                ("gutterActiveText", t.gutterActiveText),
                ("statusBackground", t.statusBackground), ("statusText", t.statusText),
            ] {
                XCTAssertTrue(isHex(value), "\(t.name).\(label) = \(value) is not #RRGGBB")
            }
            for (i, hex) in t.resolvedANSI.indexed.enumerated() {
                XCTAssertTrue(isHex(hex), "\(t.name) ANSI \(i) = \(hex) is not #RRGGBB")
            }
        }
    }

    /// Every theme added alongside the ANSI feature carries its own 16 colours —
    /// the whole reason the fields exist. (Older built-ins intentionally keep
    /// `nil` and fall back, since inventing ANSI for someone else's theme would
    /// be a fabrication.)
    func testNewThemesDeclareTheirOwnANSI() {
        let named = ["Windshield Dark", "Windshield Light", "Rosé Pine", "Rosé Pine Moon",
                     "Rosé Pine Dawn", "Kanagawa Wave", "Everforest Dark", "Everforest Light",
                     "Night Owl", "Catppuccin Latte", "GitHub Light"]
        for name in named {
            let t = try! XCTUnwrap(BuiltInThemes.all.first { $0.name == name })
            XCTAssertNotNil(t.ansiRed, "\(name) must declare its own ANSI")
            XCTAssertNotNil(t.ansiBrightWhite, "\(name) must declare a complete ANSI set")
            XCTAssertNotEqual(t.resolvedANSI, ANSIColors.curated(isDark: t.isDark),
                              "\(name) declares ANSI, so it must not equal the curated fallback")
        }
    }

    // MARK: - Windshield — the signature theme's design invariants
    //
    // These encode the thesis: GREYSCALE SYNTAX, FULL-COLOUR SIGNAL. They exist
    // to fail loudly if someone later "improves" the theme by saturating the
    // code or muting the terminal — which would quietly delete the whole point.

    private var windshields: [ThemePalette] { [BuiltInThemes.windshieldDark, BuiltInThemes.windshieldLight] }

    /// Syntax must be greyscale: hue is removed as a channel so that the diff
    /// and git colours are the only chroma on screen.
    func testWindshieldSyntaxIsGreyscale() {
        for t in windshields {
            for (role, hex) in syntaxRoles(t) {
                XCTAssertLessThanOrEqual(
                    spread(hex), 12,
                    "\(t.name).\(role) = \(hex) is not greyscale — the theme's premise is that "
                    + "syntax carries no hue; colour belongs to the diff/git/terminal signal only")
            }
            for (role, hex) in [("background", t.background), ("selection", t.selection),
                                ("gutterText", t.gutterText), ("cursor", t.cursor)] {
                XCTAssertLessThanOrEqual(spread(hex), 12, "\(t.name).\(role) must stay greyscale")
            }
        }
    }

    /// …and signal must NOT be greyscale. The accent is this app's git-*modified*
    /// colour, and ANSI red/green are how an agent says "error" / "passed".
    func testWindshieldSignalKeepsItsColour() {
        for t in windshields {
            XCTAssertGreaterThan(spread(t.accent), 60,
                                 "\(t.name).accent is the git-modified signal — it must stay saturated")
            let ansi = t.resolvedANSI
            for (slot, hex) in [("red", ansi.red), ("green", ansi.green), ("blue", ansi.blue),
                                ("magenta", ansi.magenta), ("cyan", ansi.cyan),
                                ("brightRed", ansi.brightRed), ("brightGreen", ansi.brightGreen)] {
                XCTAssertGreaterThan(spread(hex), 60,
                                     "\(t.name) ANSI \(slot) = \(hex) must stay saturated — the "
                                     + "terminal's colour carries meaning the editor's doesn't")
            }
        }
    }

    /// The accent is the git-*modified* colour, while *added* and *deleted* are
    /// fixed green/red in the app. Its hue must stay far from both or the three
    /// git states become confusable.
    func testWindshieldAccentIsFarFromTheDiffHues() {
        func hue(_ hex: String) -> Double {
            let c = rgb(hex)
            let (r, g, b) = (c.r / 255, c.g / 255, c.b / 255)
            let mx = max(r, g, b), mn = min(r, g, b), d = mx - mn
            guard d > 0 else { return 0 }
            let h: Double
            if mx == r { h = ((g - b) / d).truncatingRemainder(dividingBy: 6) }
            else if mx == g { h = (b - r) / d + 2 }
            else { h = (r - g) / d + 4 }
            return (h * 60 + 360).truncatingRemainder(dividingBy: 360)
        }
        func dist(_ a: Double, _ b: Double) -> Double {
            let d = abs(a - b).truncatingRemainder(dividingBy: 360)
            return min(d, 360 - d)
        }
        let addGreen = hue("#3DB554"), deleteRed = hue("#F24F4A")
        for t in windshields {
            let a = hue(t.accent)
            XCTAssertGreaterThan(dist(a, addGreen), 90, "\(t.name) accent too near the add-green")
            XCTAssertGreaterThan(dist(a, deleteRed), 90, "\(t.name) accent too near the delete-red")
        }
    }

    /// Greyscale removes hue as a redundant cue, so luminance alone must carry
    /// legibility: every syntax tier — comments included — clears 4.5:1.
    func testWindshieldContrastFloors() {
        for t in windshields {
            for (role, hex) in syntaxRoles(t) {
                XCTAssertGreaterThanOrEqual(
                    contrast(hex, t.background), 4.5,
                    "\(t.name).\(role) falls below 4.5:1 — with no hue to lean on, it becomes unreadable")
            }
            // The gutter must recede below the comment tier but stay legible.
            let gutter = contrast(t.gutterText, t.gutterBackground)
            XCTAssertGreaterThan(gutter, 3.0, "\(t.name) gutter text is illegible")
            XCTAssertLessThan(gutter, contrast(t.comment, t.background),
                              "\(t.name) gutter must not out-shout the code")
            // Selection must not swallow the caret.
            XCTAssertGreaterThan(contrast(t.cursor, t.selection), 4.5,
                                 "\(t.name) selection swallows the cursor")
            XCTAssertGreaterThan(contrast(t.foreground, t.selection), 4.5,
                                 "\(t.name) selected text is unreadable")
        }
    }

    /// Every ANSI slot legible on the theme's own background — including the
    /// light variant, where the usual "brights are lighter" convention fails.
    /// ANSI black is exempt: slot 0 is a background/block colour by convention.
    func testWindshieldANSIIsLegible() {
        for t in windshields {
            let ansi = t.resolvedANSI
            for (i, hex) in ansi.indexed.enumerated() where i != 0 {
                XCTAssertGreaterThanOrEqual(
                    contrast(hex, t.background), 4.5,
                    "\(t.name) ANSI \(i) = \(hex) is not legible on \(t.background)")
            }
        }
    }

    /// The terminal and the editor speak one vocabulary: a failing test's red is
    /// literally the same red as a deleted line, and a passing test's green the
    /// same green as an added one.
    func testWindshieldANSIMatchesTheAppsDiffConstants() {
        let ansi = BuiltInThemes.windshieldDark.resolvedANSI
        XCTAssertEqual(ansi.green.uppercased(), "#3DB554")   // GitStatusMap added
        XCTAssertEqual(ansi.red.uppercased(), "#F24F4A")     // GitStatusMap deleted
        XCTAssertEqual(ansi.magenta.uppercased(),
                       BuiltInThemes.windshieldDark.accent.uppercased())
    }

    /// On a light background "bright" must mean *more contrast*, not more
    /// luminance — the conventional lightening walks brights into the page.
    func testWindshieldLightBrightsAreDarkerThanTheirNormals() {
        let t = BuiltInThemes.windshieldLight
        let a = t.resolvedANSI
        for (normal, bright, slot) in [(a.red, a.brightRed, "red"), (a.green, a.brightGreen, "green"),
                                       (a.yellow, a.brightYellow, "yellow"), (a.blue, a.brightBlue, "blue"),
                                       (a.magenta, a.brightMagenta, "magenta"), (a.cyan, a.brightCyan, "cyan")] {
            XCTAssertGreaterThan(
                contrast(bright, t.background), contrast(normal, t.background),
                "light ANSI bright\(slot) must out-contrast \(slot), not out-lighten it")
        }
        // Bright black stays the dimmest slot, so dimmed output still reads dim.
        XCTAssertLessThan(contrast(a.brightBlack, t.background), contrast(a.white, t.background))
    }
}
