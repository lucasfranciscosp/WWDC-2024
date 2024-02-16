// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "WWDC24",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "WWDC24",
            targets: ["AppModule"],
            bundleIdentifier: "com.lucasfrancisco.WWDC24",
            teamIdentifier: "Q7Z5S76S2J",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .cloud),
            accentColor: .presetColor(.yellow),
            supportedDeviceFamilies: [
                .pad
            ],
            supportedInterfaceOrientations: [
                .landscapeRight,
                .landscapeLeft
            ],
            appCategory: .puzzleGames
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", "1.2.0"..<"2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms")
            ],
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)