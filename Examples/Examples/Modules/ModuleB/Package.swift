// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModuleB",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ModuleB",
            targets: ["ModuleB"]
        ),
    ],
    dependencies: [.package(path: "../../Navigation/ExamplesNavigation")],
    targets: [
        .target(
            name: "ModuleB",
            dependencies: [.product(name: "ExamplesNavigation", package: "ExamplesNavigation")]
        )
    ]
)
