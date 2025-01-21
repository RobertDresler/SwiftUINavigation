// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArchitectureViewOnly",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ArchitectureViewOnly",
            targets: ["ArchitectureViewOnly"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../../SwiftUINavigation"),
        .package(path: "../../Services/Shared")
    ],
    targets: [
        .target(
            name: "ArchitectureViewOnly",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "Shared", package: "Shared")
            ]
        )
    ]
)
