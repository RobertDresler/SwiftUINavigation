// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "App",
            targets: ["App"]
        ),
    ],
    dependencies: [.package(path: "../../Navigation/ExamplesNavigation")],
    targets: [
        .target(
            name: "App",
            dependencies: [.product(name: "ExamplesNavigation", package: "ExamplesNavigation")]
        )
    ]
)
