// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExamplesNavigation",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ExamplesNavigation",
            targets: ["ExamplesNavigation"]
        )
    ],
    targets: [
        .target(
            name: "ExamplesNavigation"
        )

    ]
)
