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

    // MARK: - Signature — Windshield
    //
    // The only themes here designed FOR this app rather than ported into it.

    /// Windshield Dark — the signature review-first theme. **Greyscale syntax,
    /// full-colour signal.**
    ///
    /// ## The thesis
    ///
    /// Every other theme in this file was designed for *writing* code, so each
    /// one spends its colour budget on the language: keywords pink, strings
    /// green, types cyan. Sidewatch is a cockpit for *reviewing* what an agent
    /// already wrote. Here the language is the constant and **the change is the
    /// variable** — so Windshield spends its entire colour budget on the change
    /// and pays for it by rendering the code itself in greyscale.
    ///
    /// The code is a ladder of silvers separated by ~6.4 L\* per tier, ordered by
    /// what a reviewer scans first: keyword brightest, then function, type,
    /// identifiers, literals, comment dimmest. Hue is removed as a channel, so
    /// luminance has to carry the whole load alone — which is why every tier is
    /// held at or above 4.5:1 on the background (comments included, at 4.55:1;
    /// most themes let comments fall to 2.5–3.5:1 and lean on hue to rescue
    /// them). Derived from the app icon: a near-black tile, a silver windshield,
    /// one black lens.
    ///
    /// ## The split a future contributor must not "fix"
    ///
    /// **Syntax is greyscale. Signal is not.** Signal means: the diff tint, the
    /// git status colours, and the terminal's ANSI palette — the agent says
    /// "error" in red and "passed" in green, and reading that output is the
    /// point of the app. Those stay fully saturated. Against greyscale code they
    /// are the only chroma on screen, which is the entire design: the change
    /// doesn't merely stand out, it is the only thing there is to see.
    ///
    /// So: do **not** saturate the syntax roles, and do **not** desaturate the
    /// ANSI/accent roles. Either edit collapses the theme into an ordinary one.
    /// Measured, the loudest syntax role carries chroma 2.9 against the diff
    /// red's 72.8 — a 24× ratio that *is* the design, not an accident.
    ///
    /// ## Why the accent is indigo
    ///
    /// ``ThemePalette/accent`` is not decoration in this app: it is the git
    /// *modified* colour (inline diff tint, gutter bar, minimap, tree and tab
    /// titles), while *added* and *deleted* are hardcoded green `#3DB554` and
    /// red `#F24F4A`. Those two hues sit at 131.5° and 1.8°, so the hue that is
    /// maximally distant from **both** — the one colour that cannot be mistaken
    /// for either "added" or "deleted" — is 247°, indigo, 115° from each. That
    /// is the accent, and it is the one exception to the greyscale rule because
    /// by the split above it is signal, not syntax.
    ///
    /// The ANSI red and green are pinned to those same diff constants (ΔE 0.00),
    /// so a failing test in the terminal is literally the same red as a deleted
    /// line in the editor — one vocabulary across both panes.
    public static let windshieldDark = ThemePalette(
        name: "Windshield Dark",
        appearance: "dark",
        background: "#101114",
        foreground: "#BDC1C5",
        cursor: "#F1F5FA",
        selection: "#252930",
        comment: "#797D80",
        string: "#898D91",
        keyword: "#F1F5FA",
        type: "#CFD3D8",
        number: "#9A9EA2",
        function: "#E0E4E8",
        variable: "#BDC1C5",
        property: "#ACB0B4",
        accent: "#9A8CFF",
        sidebarBackground: "#0C0D10",
        sidebarText: "#9A9EA2",
        tabBarBackground: "#0A0B0D",
        tabText: "#797D80",
        tabActiveText: "#F1F5FA",
        border: "#22252A",
        gutterBackground: "#101114",
        gutterText: "#6B6F73",
        gutterActiveText: "#CFD3D8",
        statusBackground: "#0A0B0D",
        statusText: "#9A9EA2",
        // Signal, deliberately at full chroma. Red and green ARE the app's diff
        // constants; magenta is the accent/"modified" indigo. ANSI black sits
        // just above the background by universal convention (terminals use slot 0
        // as a background/block colour, not as text) — bright black is the
        // readable grey programs actually dim text with.
        ansiBlack: "#1A1D22", ansiRed: "#F24F4A", ansiGreen: "#3DB554",
        ansiYellow: "#D9A441", ansiBlue: "#6E8AF0", ansiMagenta: "#9A8CFF",
        ansiCyan: "#4FB6C4", ansiWhite: "#BDC1C5",
        ansiBrightBlack: "#797D80", ansiBrightRed: "#FF6F6A",
        ansiBrightGreen: "#5FD97A", ansiBrightYellow: "#F0C46A",
        ansiBrightBlue: "#93A9FF", ansiBrightMagenta: "#B9A9FF",
        ansiBrightCyan: "#6FD3E0", ansiBrightWhite: "#F1F5FA"
    )

    /// Windshield Light — the daylight half of the signature pair; the icon
    /// inverted to its silver-on-white side.
    ///
    /// Same thesis as ``windshieldDark``: greyscale syntax, full-colour signal.
    /// The ladder inverts (keyword darkest at 17.7:1 → comment lightest at
    /// 4.5:1) and the accent deepens to indigo `#4338CA` so it still clears
    /// 4.5:1 as text on white while staying ~115° from the add-green and
    /// delete-red.
    ///
    /// ## The one place this is not a mirror of the dark theme
    ///
    /// Its ANSI palette is rebuilt on a rule the usual light palettes get wrong:
    /// **on a light background "bright" means more contrast, not more
    /// luminance.** Lightening a bright variant — the conventional move, and what
    /// VS Code's own light palette does — walks it toward the background and
    /// destroys it: VS Code's bright green `#14CE14` scores 2.13:1 on white and
    /// its bright white `#A5A5A5` scores 2.46:1, i.e. an agent's "tests passed"
    /// is barely legible. Here every bright variant is *darker* and more
    /// saturated than its normal, so all 16 slots clear 4.5:1 (worst 4.52) while
    /// each normal/bright pair stays ≥5.9 ΔE apart. Bright black remains the
    /// dimmest slot, so programs dimming text still read as dimmed.
    public static let windshieldLight = ThemePalette(
        name: "Windshield Light",
        appearance: "light",
        background: "#FCFCFD",
        foreground: "#3B3E41",
        cursor: "#131619",
        selection: "#D8DCE2",
        comment: "#71757A",
        string: "#63666A",
        keyword: "#131619",
        type: "#2D3134",
        number: "#565A5D",
        function: "#212427",
        variable: "#3B3E41",
        property: "#484C4F",
        accent: "#4338CA",
        sidebarBackground: "#F4F5F7",
        sidebarText: "#484C4F",
        tabBarBackground: "#EDEEF1",
        tabText: "#71757A",
        tabActiveText: "#131619",
        border: "#DFE1E5",
        gutterBackground: "#FCFCFD",
        gutterText: "#868B92",
        gutterActiveText: "#2D3134",
        statusBackground: "#EDEEF1",
        statusText: "#484C4F",
        ansiBlack: "#131619", ansiRed: "#C0332C", ansiGreen: "#1F7A33",
        ansiYellow: "#7E5A0E", ansiBlue: "#2F49B8", ansiMagenta: "#4338CA",
        ansiCyan: "#136E7C", ansiWhite: "#6B7075",
        ansiBrightBlack: "#71757A", ansiBrightRed: "#9C241E",
        ansiBrightGreen: "#145E27", ansiBrightYellow: "#654807",
        ansiBrightBlue: "#1F35A0", ansiBrightMagenta: "#3325B0",
        ansiBrightCyan: "#0B5764", ansiBrightWhite: "#3B3E41"
    )

    /// Claude — a warm-charcoal theme built around Anthropic's brand clay
    /// (`#D97757`, the colour of the Claude Code mascot), used as the accent and
    /// the caret. Unlike the greyscale Windshield pair this is a full-colour
    /// theme; its one design rule is that no syntax hue strays near the diff
    /// signal — strings/keywords/numbers live in the warm clay→amber arc, types
    /// take a single cool dusty-blue as the counterweight, and NOTHING is green
    /// or fire-red, so the add-green (`#3DB554`) and delete-red (`#F24F4A`) still
    /// own those hues on screen. Contrast verified: every syntax role and every
    /// ANSI slot clears 4.5:1 on the background (tightest real text is the
    /// comment at 4.71). ANSI red/green are pinned to the app's diff constants so
    /// a failing test reads as the same red as a deleted line.
    public static let claude = ThemePalette(
        name: "Claude",
        appearance: "dark",
        background: "#1B1917",
        foreground: "#E6E1DA",
        cursor: "#D97757",
        selection: "#3A342E",
        comment: "#8C837A",
        string: "#C9A15E",
        keyword: "#E0906F",
        type: "#9DBAC4",
        number: "#E0A06F",
        function: "#E8C07D",
        variable: "#E6E1DA",
        property: "#C4BEB4",
        accent: "#D97757",
        sidebarBackground: "#171512",
        sidebarText: "#A69E93",
        tabBarBackground: "#141210",
        tabText: "#857C72",
        tabActiveText: "#F0EBE3",
        border: "#2E2A25",
        gutterBackground: "#1B1917",
        gutterText: "#6E665C",
        gutterActiveText: "#C4BEB4",
        statusBackground: "#141210",
        statusText: "#A69E93",
        // Signal at full chroma: red/green ARE the app's diff constants, and the
        // clay accent doubles as ANSI magenta's warm neighbour. ansiBlack sits
        // just above the background (terminals use slot 0 as a block colour, not
        // text); bright black is the readable grey programs dim text with.
        ansiBlack: "#2A2622", ansiRed: "#F24F4A", ansiGreen: "#3DB554",
        ansiYellow: "#D4A24E", ansiBlue: "#7FA8C4", ansiMagenta: "#C08CC4",
        ansiCyan: "#6FB5B0", ansiWhite: "#E6E1DA",
        ansiBrightBlack: "#8C837A", ansiBrightRed: "#FF6F6A",
        ansiBrightGreen: "#5FD97A", ansiBrightYellow: "#E8C07D",
        ansiBrightBlue: "#9DC0D9", ansiBrightMagenta: "#D6A6DA",
        ansiBrightCyan: "#8FD0CB", ansiBrightWhite: "#F0EBE3"
    )

    /// Claude Code — the desktop app's dark palette from its usage/chat UI: a warm
    /// near-black, warm off-white text, the coral asterisk accent, and the
    /// periwinkle blue it uses for charts, the heatmap, and links (here the
    /// function/property color).
    public static let claudeCode = ThemePalette(
        name: "Claude Code",
        appearance: "dark",
        background: "#14130F",
        foreground: "#F2EFE7",
        cursor: "#CC785C",
        selection: "#33302A",
        comment: "#7C756A",
        string: "#B5C77C",
        keyword: "#CC785C",
        type: "#8FA9E6",
        number: "#D3A15F",
        function: "#7C8FE4",
        variable: "#F2EFE7",
        property: "#A5B4E8",
        accent: "#CC785C",
        sidebarBackground: "#100F0C",
        sidebarText: "#A8A196",
        tabBarBackground: "#0D0C0A",
        tabText: "#7C756A",
        tabActiveText: "#F2EFE7",
        border: "#272520",
        gutterBackground: "#14130F",
        gutterText: "#4C483F",
        gutterActiveText: "#A8A196",
        statusBackground: "#0D0C0A",
        statusText: "#A8A196",
        ansiBlack: "#2A2622", ansiRed: "#F24F4A", ansiGreen: "#3DB554",
        ansiYellow: "#D3A15F", ansiBlue: "#7C8FE4", ansiMagenta: "#B4A0DC",
        ansiCyan: "#7FB5C4", ansiWhite: "#F2EFE7",
        ansiBrightBlack: "#7C756A", ansiBrightRed: "#FF6F6A",
        ansiBrightGreen: "#5FD97A", ansiBrightYellow: "#E8C07D",
        ansiBrightBlue: "#9BA7E8", ansiBrightMagenta: "#C4B0EC",
        ansiBrightCyan: "#8FD0CB", ansiBrightWhite: "#FAF9F5"
    )

    // MARK: - Modern
    //
    // Designed for this app, not ported — clean "app-modern" palettes (deep neutral or
    // jewel-toned surfaces, one confident accent). ANSI is left to the curated dark/light
    // set. Each accent stays clear of the add-green (`#3DB554`) and delete-red (`#F24F4A`),
    // so the git "modified" tint it drives can never be mistaken for an add or a delete.

    /// Nebula — a deep violet space-dark with vibrant sky / cyan / lime syntax.
    public static let nebula = ThemePalette(
        name: "Nebula", appearance: "dark",
        background: "#13111C", foreground: "#CFCBDE", cursor: "#C4B5FD", selection: "#2C2942",
        comment: "#6A6685", string: "#B6E88D", keyword: "#C792EA", type: "#7DD3FC", number: "#F59E7D",
        function: "#82AAFF", variable: "#CFCBDE", property: "#67E8F9", accent: "#A78BFA",
        sidebarBackground: "#100E18", sidebarText: "#A8A3C0", tabBarBackground: "#0D0B14",
        tabText: "#6A6685", tabActiveText: "#E8E4F5", border: "#26223A",
        gutterBackground: "#13111C", gutterText: "#403B58", gutterActiveText: "#A8A3C0",
        statusBackground: "#0D0B14", statusText: "#A8A3C0")

    /// Carbon — an ultra-minimal near-black (pure neutral, no colour cast) with a single
    /// electric-blue accent. The flat "Vercel / Linear" modern look.
    public static let carbon = ThemePalette(
        name: "Carbon", appearance: "dark",
        background: "#0C0C0D", foreground: "#ECECEE", cursor: "#3B9EFF", selection: "#26262A",
        comment: "#6E6E75", string: "#7EE787", keyword: "#3B9EFF", type: "#79C0FF", number: "#D2A8FF",
        function: "#58A6FF", variable: "#ECECEE", property: "#A5D6FF", accent: "#3B9EFF",
        sidebarBackground: "#0A0A0B", sidebarText: "#9E9EA4", tabBarBackground: "#08080A",
        tabText: "#6E6E75", tabActiveText: "#F5F5F6", border: "#1D1D20",
        gutterBackground: "#0C0C0D", gutterText: "#3A3A3E", gutterActiveText: "#9E9EA4",
        statusBackground: "#08080A", statusText: "#9E9EA4")

    /// Synthwave — neon magenta + cyan on a deep indigo; the retro-modern glow.
    public static let synthwave = ThemePalette(
        name: "Synthwave", appearance: "dark",
        background: "#191228", foreground: "#E5DBF0", cursor: "#FF6AD5", selection: "#38294F",
        comment: "#7A6B94", string: "#FDE68A", keyword: "#FF6AD5", type: "#36E0E0", number: "#F97E72",
        function: "#8B7BF7", variable: "#E5DBF0", property: "#36E0E0", accent: "#FF6AD5",
        sidebarBackground: "#150F22", sidebarText: "#B4A6C8", tabBarBackground: "#110C1B",
        tabText: "#7A6B94", tabActiveText: "#F5EDFF", border: "#2E2442",
        gutterBackground: "#191228", gutterText: "#463A5E", gutterActiveText: "#B4A6C8",
        statusBackground: "#110C1B", statusText: "#B4A6C8")

    /// Frost — a cool, clean modern light theme: soft blue-white surfaces, crisp blue accent.
    public static let frost = ThemePalette(
        name: "Frost", appearance: "light",
        background: "#FBFCFE", foreground: "#2A2E37", cursor: "#3B82F6", selection: "#DBE7FB",
        comment: "#8A93A3", string: "#0F9A6A", keyword: "#7C3AED", type: "#C2410C", number: "#2563EB",
        function: "#2563EB", variable: "#2A2E37", property: "#0E7490", accent: "#3B82F6",
        sidebarBackground: "#F1F4F9", sidebarText: "#4A505C", tabBarBackground: "#E9EEF5",
        tabText: "#8A93A3", tabActiveText: "#1A1E27", border: "#DBE1EA",
        gutterBackground: "#FBFCFE", gutterText: "#AEB6C4", gutterActiveText: "#4A505C",
        statusBackground: "#E9EEF5", statusText: "#4A505C")

    // MARK: - Ports
    //
    // Faithful to each project's published palette. Where a theme's own comment
    // colour is low-contrast, it is kept as published rather than "improved" —
    // a port that doesn't match the original everywhere else is a broken port.

    /// Rosé Pine — "all natural pine, faux fur and a bit of soho vibes."
    ///
    /// Palette from the official `@rose-pine/palette` export; roles and the ANSI
    /// set from the Rosé Pine VS Code theme. Note the upstream mapping is
    /// deliberately unconventional: ANSI green is *pine* (a blue) and ANSI cyan
    /// is *rose*, and normal/bright are the same colour in every slot but black.
    public static let rosePine = ThemePalette(
        name: "Rosé Pine", appearance: "dark",
        background: "#191724", foreground: "#E0DEF4", cursor: "#E0DEF4", selection: "#403D52",
        comment: "#6E6A86", string: "#F6C177", keyword: "#31748F", type: "#9CCFD8", number: "#EBBCBA",
        function: "#EBBCBA", variable: "#E0DEF4", property: "#9CCFD8", accent: "#C4A7E7",
        sidebarBackground: "#1F1D2E", sidebarText: "#908CAA", tabBarBackground: "#1F1D2E",
        tabText: "#6E6A86", tabActiveText: "#E0DEF4", border: "#26233A",
        gutterBackground: "#191724", gutterText: "#6E6A86", gutterActiveText: "#E0DEF4",
        statusBackground: "#1F1D2E", statusText: "#908CAA",
        ansiBlack: "#26233A", ansiRed: "#EB6F92", ansiGreen: "#31748F",
        ansiYellow: "#F6C177", ansiBlue: "#9CCFD8", ansiMagenta: "#C4A7E7",
        ansiCyan: "#EBBCBA", ansiWhite: "#E0DEF4",
        ansiBrightBlack: "#908CAA", ansiBrightRed: "#EB6F92",
        ansiBrightGreen: "#31748F", ansiBrightYellow: "#F6C177",
        ansiBrightBlue: "#9CCFD8", ansiBrightMagenta: "#C4A7E7",
        ansiBrightCyan: "#EBBCBA", ansiBrightWhite: "#E0DEF4")

    /// Rosé Pine Moon — the softer, slightly lifted variant of ``rosePine``.
    public static let rosePineMoon = ThemePalette(
        name: "Rosé Pine Moon", appearance: "dark",
        background: "#232136", foreground: "#E0DEF4", cursor: "#E0DEF4", selection: "#44415A",
        comment: "#6E6A86", string: "#F6C177", keyword: "#3E8FB0", type: "#9CCFD8", number: "#EA9A97",
        function: "#EA9A97", variable: "#E0DEF4", property: "#9CCFD8", accent: "#C4A7E7",
        sidebarBackground: "#2A273F", sidebarText: "#908CAA", tabBarBackground: "#2A273F",
        tabText: "#6E6A86", tabActiveText: "#E0DEF4", border: "#393552",
        gutterBackground: "#232136", gutterText: "#6E6A86", gutterActiveText: "#E0DEF4",
        statusBackground: "#2A273F", statusText: "#908CAA",
        ansiBlack: "#393552", ansiRed: "#EB6F92", ansiGreen: "#3E8FB0",
        ansiYellow: "#F6C177", ansiBlue: "#9CCFD8", ansiMagenta: "#C4A7E7",
        ansiCyan: "#EA9A97", ansiWhite: "#E0DEF4",
        ansiBrightBlack: "#908CAA", ansiBrightRed: "#EB6F92",
        ansiBrightGreen: "#3E8FB0", ansiBrightYellow: "#F6C177",
        ansiBrightBlue: "#9CCFD8", ansiBrightMagenta: "#C4A7E7",
        ansiBrightCyan: "#EA9A97", ansiBrightWhite: "#E0DEF4")

    /// Rosé Pine Dawn — the light variant.
    ///
    /// `text` is `#575279`, per the palette's `dist/` export and all six shipped
    /// VS Code theme JSONs (the repo's `palette.json` disagrees with `#464261`,
    /// but nothing consumes that file and it predates the built output).
    public static let rosePineDawn = ThemePalette(
        name: "Rosé Pine Dawn", appearance: "light",
        background: "#FAF4ED", foreground: "#575279", cursor: "#575279", selection: "#DFDAD9",
        comment: "#9893A5", string: "#EA9D34", keyword: "#286983", type: "#56949F", number: "#D7827E",
        function: "#D7827E", variable: "#575279", property: "#56949F", accent: "#907AA9",
        sidebarBackground: "#FFFAF3", sidebarText: "#797593", tabBarBackground: "#FFFAF3",
        tabText: "#9893A5", tabActiveText: "#575279", border: "#F2E9E1",
        gutterBackground: "#FAF4ED", gutterText: "#9893A5", gutterActiveText: "#575279",
        statusBackground: "#FFFAF3", statusText: "#797593",
        ansiBlack: "#F2E9E1", ansiRed: "#B4637A", ansiGreen: "#286983",
        ansiYellow: "#EA9D34", ansiBlue: "#56949F", ansiMagenta: "#907AA9",
        ansiCyan: "#D7827E", ansiWhite: "#575279",
        ansiBrightBlack: "#797593", ansiBrightRed: "#B4637A",
        ansiBrightGreen: "#286983", ansiBrightYellow: "#EA9D34",
        ansiBrightBlue: "#56949F", ansiBrightMagenta: "#907AA9",
        ansiBrightCyan: "#D7827E", ansiBrightWhite: "#575279")

    /// Kanagawa Wave — inspired by Katsushika Hokusai's *The Great Wave*.
    ///
    /// Palette and the 16 terminal colors from `kanagawa.nvim` (`colors.lua` and
    /// the `term` block of `themes.lua`), cross-checked against the project's
    /// shipped kitty config. Background is `sumiInk3`, the editor background the
    /// project itself uses — not `sumiInk0`.
    public static let kanagawa = ThemePalette(
        name: "Kanagawa Wave", appearance: "dark",
        background: "#1F1F28", foreground: "#DCD7BA", cursor: "#C8C093", selection: "#2D4F67",
        comment: "#727169", string: "#98BB6C", keyword: "#957FB8", type: "#7AA89F", number: "#D27E99",
        function: "#7E9CD8", variable: "#DCD7BA", property: "#E6C384", accent: "#7E9CD8",
        sidebarBackground: "#16161D", sidebarText: "#C8C093", tabBarBackground: "#16161D",
        tabText: "#727169", tabActiveText: "#DCD7BA", border: "#2A2A37",
        gutterBackground: "#1F1F28", gutterText: "#54546D", gutterActiveText: "#C0A36E",
        statusBackground: "#16161D", statusText: "#C8C093",
        ansiBlack: "#16161D", ansiRed: "#C34043", ansiGreen: "#76946A",
        ansiYellow: "#C0A36E", ansiBlue: "#7E9CD8", ansiMagenta: "#957FB8",
        ansiCyan: "#6A9589", ansiWhite: "#C8C093",
        ansiBrightBlack: "#727169", ansiBrightRed: "#E82424",
        ansiBrightGreen: "#98BB6C", ansiBrightYellow: "#E6C384",
        ansiBrightBlue: "#7FB4CA", ansiBrightMagenta: "#938AA9",
        ansiBrightCyan: "#7AA89F", ansiBrightWhite: "#DCD7BA")

    /// Everforest Dark (medium) — a green-based, low-contrast forest palette.
    ///
    /// Palette from `autoload/everforest.vim`. ANSI follows the VS Code port
    /// rather than the vim colorscheme: the two disagree on black/white, and
    /// only the port gives brights a distinct bright-black/bright-white.
    public static let everforestDark = ThemePalette(
        name: "Everforest Dark", appearance: "dark",
        background: "#2D353B", foreground: "#D3C6AA", cursor: "#D3C6AA", selection: "#543A48",
        comment: "#859289", string: "#A7C080", keyword: "#E67E80", type: "#DBBC7F", number: "#D699B6",
        function: "#A7C080", variable: "#D3C6AA", property: "#7FBBB3", accent: "#7FBBB3",
        sidebarBackground: "#232A2E", sidebarText: "#9DA9A0", tabBarBackground: "#232A2E",
        tabText: "#859289", tabActiveText: "#D3C6AA", border: "#3D484D",
        gutterBackground: "#2D353B", gutterText: "#7A8478", gutterActiveText: "#D3C6AA",
        statusBackground: "#232A2E", statusText: "#9DA9A0",
        ansiBlack: "#343F44", ansiRed: "#E67E80", ansiGreen: "#A7C080",
        ansiYellow: "#DBBC7F", ansiBlue: "#7FBBB3", ansiMagenta: "#D699B6",
        ansiCyan: "#83C092", ansiWhite: "#D3C6AA",
        ansiBrightBlack: "#859289", ansiBrightRed: "#E67E80",
        ansiBrightGreen: "#A7C080", ansiBrightYellow: "#DBBC7F",
        ansiBrightBlue: "#7FBBB3", ansiBrightMagenta: "#D699B6",
        ansiBrightCyan: "#83C092", ansiBrightWhite: "#D3C6AA")

    /// Everforest Light (medium) — the light counterpart to ``everforestDark``.
    public static let everforestLight = ThemePalette(
        name: "Everforest Light", appearance: "light",
        background: "#FDF6E3", foreground: "#5C6A72", cursor: "#5C6A72", selection: "#EAEDC8",
        comment: "#939F91", string: "#8DA101", keyword: "#F85552", type: "#DFA000", number: "#DF69BA",
        function: "#8DA101", variable: "#5C6A72", property: "#3A94C5", accent: "#3A94C5",
        sidebarBackground: "#F4F0D9", sidebarText: "#5C6A72", tabBarBackground: "#EFEBD4",
        tabText: "#939F91", tabActiveText: "#5C6A72", border: "#E6E2CC",
        gutterBackground: "#FDF6E3", gutterText: "#A6B0A0", gutterActiveText: "#5C6A72",
        statusBackground: "#EFEBD4", statusText: "#5C6A72",
        ansiBlack: "#5C6A72", ansiRed: "#F85552", ansiGreen: "#8DA101",
        ansiYellow: "#DFA000", ansiBlue: "#3A94C5", ansiMagenta: "#DF69BA",
        ansiCyan: "#35A77C", ansiWhite: "#939F91",
        ansiBrightBlack: "#5C6A72", ansiBrightRed: "#F85552",
        ansiBrightGreen: "#8DA101", ansiBrightYellow: "#DFA000",
        ansiBrightBlue: "#3A94C5", ansiBrightMagenta: "#DF69BA",
        ansiBrightCyan: "#35A77C", ansiBrightWhite: "#F4F0D9")

    /// Night Owl — Sarah Drasner's theme "for the night owls out there."
    ///
    /// Imported from the published VS Code theme (also this package's
    /// `nightowl` test fixture), including its own `terminal.ansi*` set.
    public static let nightOwl = ThemePalette(
        name: "Night Owl", appearance: "dark",
        background: "#011627", foreground: "#D6DEEB", cursor: "#80A4C2", selection: "#1D3B53",
        comment: "#637777", string: "#ECC48D", keyword: "#C792EA", type: "#FFCB8B", number: "#F78C6C",
        function: "#82AAFF", variable: "#C5E478", property: "#BAEBE2", accent: "#82AAFF",
        sidebarBackground: "#011627", sidebarText: "#89A4BB", tabBarBackground: "#011627",
        tabText: "#5F7E97", tabActiveText: "#D2DEE7", border: "#122D42",
        gutterBackground: "#011627", gutterText: "#4B6479", gutterActiveText: "#C5E4FD",
        statusBackground: "#011627", statusText: "#5F7E97",
        ansiBlack: "#011627", ansiRed: "#EF5350", ansiGreen: "#22DA6E",
        ansiYellow: "#C5E478", ansiBlue: "#82AAFF", ansiMagenta: "#C792EA",
        ansiCyan: "#21C7A8", ansiWhite: "#FFFFFF",
        ansiBrightBlack: "#575656", ansiBrightRed: "#EF5350",
        ansiBrightGreen: "#22DA6E", ansiBrightYellow: "#FFEB95",
        ansiBrightBlue: "#82AAFF", ansiBrightMagenta: "#C792EA",
        ansiBrightCyan: "#7FDBCA", ansiBrightWhite: "#FFFFFF")

    /// Catppuccin Latte — the light variant of the pastel Catppuccin family, and
    /// the counterpart to ``catppuccin`` (Mocha).
    ///
    /// Palette from `catppuccin/palette`; roles and ANSI from the Catppuccin VS
    /// Code extension. ANSI brights 9–14 are bespoke brightened values that do
    /// not appear in the named palette.
    ///
    /// One deliberate deviation: `cursor` is `text`, not the `rosewater` the
    /// Catppuccin extension specifies. Rosewater is a pale salmon that works as
    /// a caret on the dark variants but scores only 1.71:1 against Latte's own
    /// `surface0` selection — i.e. the caret disappears exactly when you select
    /// the text you're trying to edit. `text` is the same palette's own colour
    /// and restores it to 5.17:1.
    public static let catppuccinLatte = ThemePalette(
        name: "Catppuccin Latte", appearance: "light",
        background: "#EFF1F5", foreground: "#4C4F69", cursor: "#4C4F69", selection: "#CCD0DA",
        comment: "#7C7F93", string: "#40A02B", keyword: "#8839EF", type: "#DF8E1D", number: "#FE640B",
        function: "#1E66F5", variable: "#4C4F69", property: "#179299", accent: "#8839EF",
        sidebarBackground: "#E6E9EF", sidebarText: "#5C5F77", tabBarBackground: "#DCE0E8",
        tabText: "#8C8FA1", tabActiveText: "#4C4F69", border: "#BCC0CC",
        gutterBackground: "#EFF1F5", gutterText: "#9CA0B0", gutterActiveText: "#5C5F77",
        statusBackground: "#DCE0E8", statusText: "#5C5F77",
        ansiBlack: "#5C5F77", ansiRed: "#D20F39", ansiGreen: "#40A02B",
        ansiYellow: "#DF8E1D", ansiBlue: "#1E66F5", ansiMagenta: "#EA76CB",
        ansiCyan: "#179299", ansiWhite: "#ACB0BE",
        ansiBrightBlack: "#6C6F85", ansiBrightRed: "#DE293E",
        ansiBrightGreen: "#49AF3D", ansiBrightYellow: "#EEA02D",
        ansiBrightBlue: "#456EFF", ansiBrightMagenta: "#FE85D8",
        ansiBrightCyan: "#2D9FA8", ansiBrightWhite: "#BCC0CC")

    /// GitHub Light — GitHub's light web/editor scheme, and the counterpart to
    /// ``githubDark``.
    ///
    /// Values from a real build of `primer/github-vscode-theme` (its `themes/*.json`
    /// are generated, not committed). `selection` is the author's intended
    /// `alpha(accent.fg, 0.2)` flattened over white: upstream declares
    /// `editor.selectionBackground` twice in one object literal, so the key is
    /// dropped from every non-high-contrast build and the theme silently
    /// inherits VS Code's default.
    public static let githubLight = ThemePalette(
        name: "GitHub Light", appearance: "light",
        background: "#FFFFFF", foreground: "#1F2328", cursor: "#0969DA", selection: "#CEE1F8",
        comment: "#6E7781", string: "#0A3069", keyword: "#CF222E", type: "#953800", number: "#0550AE",
        function: "#8250DF", variable: "#953800", property: "#0550AE", accent: "#0969DA",
        sidebarBackground: "#F6F8FA", sidebarText: "#1F2328", tabBarBackground: "#F6F8FA",
        tabText: "#656D76", tabActiveText: "#1F2328", border: "#D0D7DE",
        gutterBackground: "#FFFFFF", gutterText: "#8C959F", gutterActiveText: "#1F2328",
        statusBackground: "#FFFFFF", statusText: "#656D76",
        ansiBlack: "#24292F", ansiRed: "#CF222E", ansiGreen: "#116329",
        ansiYellow: "#4D2D00", ansiBlue: "#0969DA", ansiMagenta: "#8250DF",
        ansiCyan: "#1B7C83", ansiWhite: "#6E7781",
        ansiBrightBlack: "#57606A", ansiBrightRed: "#A40E26",
        ansiBrightGreen: "#1A7F37", ansiBrightYellow: "#633C01",
        ansiBrightBlue: "#218BFF", ansiBrightMagenta: "#A475F9",
        ansiBrightCyan: "#3192AA", ansiBrightWhite: "#8C959F")

    /// Every built-in palette, in theme-picker display order (not alphabetical):
    /// the signature pair, then darks, then lights.
    public static let all: [ThemePalette] = [
        windshieldDark, windshieldLight, claude, claudeCode,
        nebula, carbon, synthwave,
        oneDark, dracula, tokyoNight, catppuccin, rosePine, rosePineMoon,
        kanagawa, everforestDark, nightOwl, nord, gruvbox, ayu,
        monokai, githubDark, solarizedDark, neon,
        frost, catppuccinLatte, rosePineDawn, githubLight, everforestLight, solarizedLight,
    ]
}
