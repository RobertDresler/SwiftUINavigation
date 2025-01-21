// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlagsRepository",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "FlagsRepository",
            targets: ["FlagsRepository"]
        )
    ],
    dependencies: [
        .package(path: "../SwiftUINavigation")
    ],
    targets: [
        .target(
            name: "FlagsRepository",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation")
            ]
        )

    ]
)
