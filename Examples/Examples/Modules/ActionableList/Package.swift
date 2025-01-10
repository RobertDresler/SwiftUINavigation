// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActionableList",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ActionableList",
            targets: ["ActionableList"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/Shared"),
        .package(path: "../../Services/UserRepository")
    ],
    targets: [
        .target(
            name: "ActionableList",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "Shared", package: "Shared"),
                .product(name: "UserRepository", package: "UserRepository")
            ]
        )
    ]
)
