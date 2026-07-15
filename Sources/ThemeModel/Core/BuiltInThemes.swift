//
//  BuiltInThemes.swift
//  SwiftThemeModel
//
//  A set of ready-made hex palettes.
//
//  Created by David Sherlock on 7/9/26.
//

import Foundation

/// Ready-made ``ThemePalette``s for well-known editor color schemes.
///
/// Use one directly (e.g. `BuiltInThemes.dracula`) or iterate ``all`` to
/// populate a theme picker.
public enum BuiltInThemes {

    /// Monokai — the classic warm dark theme. The default palette; matches the
    /// original hardcoded Sidewatch look.
    public static let monokai = ThemePalette(
        name: "Monokai",
        appearance: "dark",
        background: "#272822",
        foreground: "#F8F8F2",
        cursor: "#F8F8F2",
        selection: "#49483C",
        comment: "#75715E",
        string: "#E6DB74",
        keyword: "#F92672",
        type: "#66D9EF",
        number: "#AE81FF",
        function: "#A6E22E",
        variable: "#FD971F",
        property: "#66D9EF",
        accent: "#F92672",
        sidebarBackground: "#24251F",
        sidebarText: "#CCCCC7",
        tabBarBackground: "#21221D",
        tabText: "#8C8B85",
        tabActiveText: "#F8F8F2",
        border: "#2E2F29",
        gutterBackground: "#2F2F2A",
        gutterText: "#90908A",
        gutterActiveText: "#CCCCC7",
        statusBackground: "#1C1D19",
        statusText: "#90908A"
    )

    /// One Dark — Atom's default dark theme.
    public static let oneDark = ThemePalette(
        name: "One Dark",
        appearance: "dark",
        background: "#282C34",
        foreground: "#ABB2BF",
        cursor: "#528BFF",
        selection: "#3E4451",
        comment: "#5C6370",
        string: "#98C379",
        keyword: "#C678DD",
        type: "#E5C07B",
        number: "#D19A66",
        function: "#61AFEF",
        variable: "#E06C75",
        property: "#56B6C2",
        accent: "#61AFEF",
        sidebarBackground: "#21252B",
        sidebarText: "#9DA5B4",
        tabBarBackground: "#21252B",
        tabText: "#6B717D",
        tabActiveText: "#D7DAE0",
        border: "#181A1F",
        gutterBackground: "#282C34",
        gutterText: "#495162",
        gutterActiveText: "#737C8C",
        statusBackground: "#21252B",
        statusText: "#9DA5B4"
    )

    /// GitHub Dark — GitHub's dark web/editor scheme.
    public static let githubDark = ThemePalette(
        name: "GitHub Dark",
        appearance: "dark",
        background: "#0D1117",
        foreground: "#C9D1D9",
        cursor: "#58A6FF",
        selection: "#163356",
        comment: "#8B949E",
        string: "#A5D6FF",
        keyword: "#FF7B72",
        type: "#FFA657",
        number: "#79C0FF",
        function: "#D2A8FF",
        variable: "#FFA657",
        property: "#7EE787",
        accent: "#58A6FF",
        sidebarBackground: "#0D1117",
        sidebarText: "#8B949E",
        tabBarBackground: "#010409",
        tabText: "#8B949E",
        tabActiveText: "#E6EDF3",
        border: "#21262D",
        gutterBackground: "#0D1117",
        gutterText: "#484F58",
        gutterActiveText: "#8B949E",
        statusBackground: "#010409",
        statusText: "#8B949E"
    )

    /// Solarized Dark — Ethan Schoonover's low-contrast dark palette.
    public static let solarizedDark = ThemePalette(
        name: "Solarized Dark",
        appearance: "dark",
        background: "#002B36",
        foreground: "#839496",
        cursor: "#93A1A1",
        selection: "#073642",
        comment: "#586E75",
        string: "#2AA198",
        keyword: "#859900",
        type: "#B58900",
        number: "#D33682",
        function: "#268BD2",
        variable: "#CB4B16",
        property: "#6C71C4",
        accent: "#268BD2",
        sidebarBackground: "#00212B",
        sidebarText: "#839496",
        tabBarBackground: "#00212B",
        tabText: "#586E75",
        tabActiveText: "#93A1A1",
        border: "#073642",
        gutterBackground: "#002B36",
        gutterText: "#586E75",
        gutterActiveText: "#93A1A1",
        statusBackground: "#001B22",
        statusText: "#586E75"
    )

    /// Solarized Light — the light counterpart to Solarized Dark.
    public static let solarizedLight = ThemePalette(
        name: "Solarized Light",
        appearance: "light",
        background: "#FDF6E3",
        foreground: "#657B83",
        cursor: "#586E75",
        selection: "#EEE8D5",
        comment: "#93A1A1",
        string: "#2AA198",
        keyword: "#859900",
        type: "#B58900",
        number: "#D33682",
        function: "#268BD2",
        variable: "#CB4B16",
        property: "#6C71C4",
        accent: "#268BD2",
        sidebarBackground: "#EEE8D5",
        sidebarText: "#657B83",
        tabBarBackground: "#EEE8D5",
        tabText: "#93A1A1",
        tabActiveText: "#586E75",
        border: "#DDD6C1",
        gutterBackground: "#FDF6E3",
        gutterText: "#B0A999",
        gutterActiveText: "#586E75",
        statusBackground: "#EEE8D5",
        statusText: "#657B83"
    )

    /// Neon — near-black with electric neon-green; hacker/terminal aesthetic.
    public static let neon = ThemePalette(
        name: "Neon",
        appearance: "dark",
        background: "#0A0E0C",
        foreground: "#C6D0CB",
        cursor: "#3DE86A",
        selection: "#1C3A2A",
        comment: "#556A5F",
        string: "#9BE8B4",
        keyword: "#3DE86A",
        type: "#B8F075",
        number: "#B991F2",
        function: "#58E6C8",
        variable: "#C6D0CB",
        property: "#6FD3E8",
        accent: "#3DE86A",
        sidebarBackground: "#08110C",
        sidebarText: "#8FA69A",
        tabBarBackground: "#070D0A",
        tabText: "#6B7D72",
        tabActiveText: "#D8E4DE",
        border: "#16211B",
        gutterBackground: "#0A0E0C",
        gutterText: "#3E4E45",
        gutterActiveText: "#9BB0A4",
        statusBackground: "#070D0A",
        statusText: "#7E9086"
    )

    /// Dracula — the popular purple-tinted dark theme.
    public static let dracula = ThemePalette(
        name: "Dracula", appearance: "dark",
        background: "#282A36", foreground: "#F8F8F2", cursor: "#F8F8F2", selection: "#44475A",
        comment: "#6272A4", string: "#F1FA8C", keyword: "#FF79C6", type: "#8BE9FD", number: "#BD93F9",
        function: "#50FA7B", variable: "#F8F8F2", property: "#8BE9FD", accent: "#BD93F9",
        sidebarBackground: "#21222C", sidebarText: "#B4B8CC", tabBarBackground: "#191A21",
        tabText: "#6272A4", tabActiveText: "#F8F8F2", border: "#191A21",
        gutterBackground: "#282A36", gutterText: "#6272A4", gutterActiveText: "#B4B8CC",
        statusBackground: "#191A21", statusText: "#B4B8CC")

    /// Nord — the arctic blue-grey palette.
    public static let nord = ThemePalette(
        name: "Nord", appearance: "dark",
        background: "#2E3440", foreground: "#D8DEE9", cursor: "#D8DEE9", selection: "#434C5E",
        comment: "#616E88", string: "#A3BE8C", keyword: "#81A1C1", type: "#8FBCBB", number: "#B48EAD",
        function: "#88C0D0", variable: "#D8DEE9", property: "#8FBCBB", accent: "#88C0D0",
        sidebarBackground: "#2B303B", sidebarText: "#AEB6C6", tabBarBackground: "#272B35",
        tabText: "#616E88", tabActiveText: "#ECEFF4", border: "#3B4252",
        gutterBackground: "#2E3440", gutterText: "#4C566A", gutterActiveText: "#AEB6C6",
        statusBackground: "#272B35", statusText: "#AEB6C6")

    /// Tokyo Night — deep indigo with pastel syntax colors.
    public static let tokyoNight = ThemePalette(
        name: "Tokyo Night", appearance: "dark",
        background: "#1A1B26", foreground: "#A9B1D6", cursor: "#C0CAF5", selection: "#33467C",
        comment: "#565F89", string: "#9ECE6A", keyword: "#BB9AF7", type: "#2AC3DE", number: "#FF9E64",
        function: "#7AA2F7", variable: "#C0CAF5", property: "#73DACA", accent: "#7AA2F7",
        sidebarBackground: "#16161E", sidebarText: "#9AA5CE", tabBarBackground: "#16161E",
        tabText: "#565F89", tabActiveText: "#C0CAF5", border: "#1F2335",
        gutterBackground: "#1A1B26", gutterText: "#363B54", gutterActiveText: "#737AA2",
        statusBackground: "#16161E", statusText: "#9AA5CE")

    /// Catppuccin Mocha — the soothing pastel dark variant.
    public static let catppuccin = ThemePalette(
        name: "Catppuccin Mocha", appearance: "dark",
        background: "#1E1E2E", foreground: "#CDD6F4", cursor: "#F5E0DC", selection: "#414458",
        comment: "#6C7086", string: "#A6E3A1", keyword: "#CBA6F7", type: "#F9E2AF", number: "#FAB387",
        function: "#89B4FA", variable: "#CDD6F4", property: "#94E2D5", accent: "#CBA6F7",
        sidebarBackground: "#181825", sidebarText: "#BAC2DE", tabBarBackground: "#11111B",
        tabText: "#6C7086", tabActiveText: "#CDD6F4", border: "#313244",
        gutterBackground: "#1E1E2E", gutterText: "#45475A", gutterActiveText: "#9399B2",
        statusBackground: "#11111B", statusText: "#BAC2DE")

    /// Gruvbox Dark — retro warm earth tones.
    public static let gruvbox = ThemePalette(
        name: "Gruvbox Dark", appearance: "dark",
        background: "#282828", foreground: "#EBDBB2", cursor: "#EBDBB2", selection: "#3C3836",
        comment: "#928374", string: "#B8BB26", keyword: "#FB4934", type: "#FABD2F", number: "#D3869B",
        function: "#8EC07C", variable: "#83A598", property: "#8EC07C", accent: "#FE8019",
        sidebarBackground: "#1D2021", sidebarText: "#D5C4A1", tabBarBackground: "#1D2021",
        tabText: "#928374", tabActiveText: "#FBF1C7", border: "#3C3836",
        gutterBackground: "#282828", gutterText: "#7C6F64", gutterActiveText: "#BDAE93",
        statusBackground: "#1D2021", statusText: "#D5C4A1")

    /// Ayu Dark — near-black with warm orange/gold accents.
    public static let ayu = ThemePalette(
        name: "Ayu Dark", appearance: "dark",
        background: "#0B0E14", foreground: "#BFBDB6", cursor: "#E6B450", selection: "#1C2733",
        comment: "#646B73", string: "#AAD94C", keyword: "#FF8F40", type: "#59C2FF", number: "#D2A6FF",
        function: "#FFB454", variable: "#BFBDB6", property: "#59C2FF", accent: "#39BAE6",
        sidebarBackground: "#0D1017", sidebarText: "#9DA3A9", tabBarBackground: "#0B0E14",
        tabText: "#646B73", tabActiveText: "#BFBDB6", border: "#1C2027",
        gutterBackground: "#0B0E14", gutterText: "#3D424D", gutterActiveText: "#8A9199",
        statusBackground: "#0B0E14", statusText: "#9DA3A9")

    /// Every built-in palette, in theme-picker display order (not alphabetical).
    public static let all: [ThemePalette] = [
        oneDark, dracula, tokyoNight, catppuccin, nord, gruvbox, ayu,
        monokai, githubDark, solarizedDark, solarizedLight, neon,
    ]
}
