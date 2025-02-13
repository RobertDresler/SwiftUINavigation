// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "SwiftUINavigation",
    platforms: [.iOS(.v16), .macOS(.v13), .macCatalyst(.v16)],
    products: [
        .library(
            name: "SwiftUINavigation",
            targets: ["SwiftUINavigation"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax", .upToNextMajor(from: "600.0.1"))
    ],
    targets: [
        .target(
            name: "SwiftUINavigation",
            dependencies: [
                "Macros"
            ]
        ),
        .macro(
            name: "Macros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        )
    ]
)
