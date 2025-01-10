// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainTabs",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "MainTabs",
            targets: ["MainTabs"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Modules/CommandsGallery"),
        .package(path: "../../Modules/Settings")
    ],
    targets: [
        .target(
            name: "MainTabs",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "CommandsGallery", package: "CommandsGallery"),
                .product(name: "Settings", package: "Settings")
            ]
        )
    ]
)
