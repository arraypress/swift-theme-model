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

    /// Every built-in theme resolves to a full 16 valid hex colors.
    func testBuiltInThemesResolveFullANSIPalette() {
        for theme in BuiltInThemes.all {
            let ansi = theme.resolvedANSI
            XCTAssertEqual(ansi.indexed.count, 16, "\(theme.name) must resolve 16 colors")
            for (i, hex) in ansi.indexed.enumerated() {
                XCTAssertTrue(isHex(hex), "\(theme.name) ANSI \(i) = \(hex) is not #RRGGBB")
            }
            XCTAssertEqual(ansi, ANSIColors.curated(isDark: theme.isDark))
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
}
