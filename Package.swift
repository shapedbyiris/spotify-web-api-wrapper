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
            targets: ["SpotifyWebAPI"]),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SpotifyWebAPI",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SpotifyWebAPITests",
            dependencies: ["SpotifyWebAPI"],
            path: "Tests"
        ),
    ]
)
