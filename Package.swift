// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SpotifyWebAPI",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "SpotifyWebAPI",
            targets: ["SpotifyWebAPI"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SpotifyWebAPI",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SpotifyWebAPITests",
            dependencies: ["SpotifyWebAPI"],
            path: "Tests"
        )
    ]
)
