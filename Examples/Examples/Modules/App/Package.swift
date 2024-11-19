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
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/UserRepository"),
        .package(path: "../../Modules/Start"),
        .package(path: "../../Modules/ModuleA"),
        .package(path: "../../Modules/Settings")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "UserRepository", package: "UserRepository"),
                .product(name: "Start", package: "Start"),
                .product(name: "ModuleA", package: "ModuleA"),
                .product(name: "Settings", package: "Settings")
            ]
        )
    ]
)
