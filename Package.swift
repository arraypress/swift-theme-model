// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ThemeModel",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "ThemeModel", targets: ["ThemeModel"]),
    ],
    targets: [
        .target(name: "ThemeModel", path: "Sources"),
        .testTarget(
            name: "ThemeModelTests",
            dependencies: ["ThemeModel"],
            path: "Tests",
            resources: [.copy("ThemeModelTests/Fixtures")]
        ),
    ]
)
