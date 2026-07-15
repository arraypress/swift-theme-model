# Swift Theme Model

A tiny, dependency-free editor **theme model** + a robust **VS Code theme importer**. Import real-world `.json` color themes (including JSONC ones with comments) into a flat, `Codable` `ThemePalette`, or use the bundled built-in palettes. Pure Foundation, zero dependencies.

## Features

- 🎨 **`ThemePalette`** — a flat, `Codable`, `Sendable` hex-based theme: editor surface + 8 syntax roles + chrome (sidebar, tabs, gutter, status bar), plus an `isDark` convenience
- 🧩 **VS Code importer** — `VSCodeThemeImporter.palette(from:fallbackName:)` maps a theme's `colors` UI keys + `tokenColors` TextMate scopes onto a palette, with sensible fallbacks for missing keys
- 🛡️ **JSONC-tolerant** — strips `//` / `/* */` comments and trailing commas (string-aware), because many published themes are JSONC and `JSONSerialization` alone rejects them
- 🎯 **Scope resolution that matches VS Code** — needles are tried specific → generic, exact scope beats prefix match, and the last matching rule wins within a tier
- 🌗 **Smart appearance detection** — honors the theme's `type` (including the high-contrast variants; `hc-light` is light), and falls back to background luminance when `type` is absent (it often lives in the extension manifest, not the theme file)
- 🔢 **Hex normalization** — expands `#RGB`/`#RGBA` shorthand, trims `#RRGGBBAA` → `#RRGGBB`, rejects non-hex values
- 📦 **12 built-in palettes** — `BuiltInThemes.all`: Monokai, One Dark, Dracula, Nord, Tokyo Night, Catppuccin Mocha, Gruvbox Dark, Ayu Dark, GitHub Dark, Solarized Dark/Light, Neon
- 🪶 **Zero dependencies** — Foundation only
- 🍎 **Cross-platform** — iOS, macOS, tvOS, watchOS, visionOS
- ✅ **Validated against real themes** — fixture tests import actual VS Code built-in and community theme files (JSONC and strict), plus unit tests of hex parsing, scope priority, and the JSONC sanitizer

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+ / visionOS 1.0+
- Swift 5.9+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/arraypress/swift-theme-model.git", from: "1.0.0")
]
```

## Usage

```swift
import ThemeModel

// Import a VS Code theme file (JSON or JSONC — both work).
let data = try Data(contentsOf: themeURL)
if let palette = VSCodeThemeImporter.palette(from: data, fallbackName: "My Theme") {
    print(palette.name, palette.isDark ? "dark" : "light")
    print(palette.keyword, palette.string, palette.background)   // "#C586C0" ...
}

// Or use a built-in.
let dracula = BuiltInThemes.dracula

// Populate a theme picker.
for theme in BuiltInThemes.all {
    print(theme.name, theme.appearance)
}

// ThemePalette is Codable — round-trip it to disk.
let saved = try JSONEncoder().encode(dracula)
let restored = try JSONDecoder().decode(ThemePalette.self, from: saved)
```

## License

MIT
