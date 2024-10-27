// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HolyQuranAnalyzer",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "HolyQuranAnalyzer",
            type: .dynamic,
            targets: ["HolyQuranAnalyzer"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HolyQuranAnalyzer",
            dependencies: [
            ]),
        .testTarget(
            name: "HolyQuranAnalyzerTests",
            dependencies: ["HolyQuranAnalyzer"])
    ])
