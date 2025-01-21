// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomNavigationBar",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CustomNavigationBar",
            targets: ["CustomNavigationBar"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../SwiftUINavigation"),
        .package(path: "../../Services/Shared")
    ],
    targets: [
        .target(
            name: "CustomNavigationBar",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "Shared", package: "Shared")
            ]
        )
    ]
)
