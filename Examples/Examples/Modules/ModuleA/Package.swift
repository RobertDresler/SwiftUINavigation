// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModuleA",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ModuleA",
            targets: ["ModuleA"]
        ),
    ],
    dependencies: [.package(path: "../../Navigation/ExamplesNavigation")],
    targets: [
        .target(
            name: "ModuleA",
            dependencies: [.product(name: "ExamplesNavigation", package: "ExamplesNavigation")]
        )
    ]
)