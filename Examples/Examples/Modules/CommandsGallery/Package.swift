// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommandsGallery",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CommandsGallery",
            targets: ["CommandsGallery"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/Shared")
    ],
    targets: [
        .target(
            name: "CommandsGallery",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "Shared", package: "Shared")
            ]
        )
    ]
)
