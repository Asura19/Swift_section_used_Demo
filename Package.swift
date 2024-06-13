// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyTool",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MyCTool",
            dependencies: []
        ),
        .executableTarget(
            name: "MyTool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "MyCTool"
            ],
            swiftSettings: [.enableExperimentalFeature("SymbolLinkageMarkers")]
        ),
    ]
)
//targets: [.target(name: "MyPackage", swiftSettings: [.enableExperimentalFeature("SymbolLinkageMarkers")])]
