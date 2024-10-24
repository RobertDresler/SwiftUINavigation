// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Start",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Start",
            targets: ["Start"]
        ),
    ],
    dependencies: [.package(path: "../../Navigation/ExamplesNavigation")],
    targets: [
        .target(
            name: "Start",
            dependencies: [.product(name: "ExamplesNavigation", package: "ExamplesNavigation")]
        )
    ]
)
