// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExamplesNavigationResolving",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ExamplesNavigationResolving",
            targets: ["ExamplesNavigationResolving"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Modules/ModuleA"),
        .package(path: "../../Modules/ModuleB")
    ],
    targets: [
        .target(
            name: "ExamplesNavigationResolving",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "ModuleA", package: "ModuleA"),
                .product(name: "ModuleB", package: "ModuleB")
            ]
        )
    ]
)
