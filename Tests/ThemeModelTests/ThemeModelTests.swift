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

    // MARK: - Built-in themes

    func testBuiltInThemesAreValid() {
        XCTAssertEqual(BuiltInThemes.monokai.name, "Monokai")
        XCTAssertTrue(BuiltInThemes.monokai.isDark)
        XCTAssertTrue(isHex(BuiltInThemes.monokai.background))
        XCTAssertFalse(BuiltInThemes.solarizedLight.isDark)
    }
}
