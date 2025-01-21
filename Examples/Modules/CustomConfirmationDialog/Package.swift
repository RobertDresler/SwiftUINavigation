// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomConfirmationDialog",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CustomConfirmationDialog",
            targets: ["CustomConfirmationDialog"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/Shared"),
        .package(path: "../../../SwiftUINavigation")
    ],
    targets: [
        .target(
            name: "CustomConfirmationDialog",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "Shared", package: "Shared"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation")
            ]
        )
    ]
)
