# Swift Theme Model

A tiny, dependency-free editor **theme model** + a robust **VS Code theme importer**. Import real-world `.json` color themes (including JSONC ones with comments) into a flat, `Codable` `ThemePalette`, or use the bundled built-in palettes.

## Features

- 🎨 **`ThemePalette`** — a flat, `Codable`, hex-based theme (editor surface + syntax + chrome roles)
- 🧩 **VS Code importer** — maps `colors` UI keys + `tokenColors` scopes onto a palette
- 🛡️ **JSONC-tolerant** — strips `//` / `/* */` comments and trailing commas (string-aware), because **many published themes are JSONC** and `JSONSerialization` alone rejects them
- 🌗 **Smart appearance detection** — uses the theme's `type`, and falls back to **background luminance** when it's absent (VS Code themes often omit `type` — it lives in the extension manifest)
- 🎯 **Hex normalization** — expands `#RGB`/`#RGBA`, trims `#RRGGBBAA` → `#RRGGBB`
- 📦 **Built-in palettes** — Monokai, One Dark, Dracula, Nord, Solarized, Tokyo Night, and more
- 🪶 **Zero dependencies** — Foundation only
- 🍎 **Cross-platform** — iOS, macOS, tvOS, watchOS, visionOS
- ✅ **Validated against real themes** — tested on VS Code's built-in themes (JSONC and strict) + community themes

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+ / visionOS 1.0+
- Swift 5.9+

## Installation

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
    print(palette.keyword, palette.string, palette.background)
}

// Or use a built-in.
let dracula = BuiltInThemes.dracula
```

## License

MIT
