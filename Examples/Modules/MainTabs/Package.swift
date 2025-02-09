// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainTabs",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "MainTabs",
            targets: ["MainTabs"]
        ),
    ],
    dependencies: [
        .package(path: "../../Modules/ActionableList")
    ],
    targets: [
        .target(
            name: "MainTabs",
            dependencies: [
                .product(name: "ActionableList", package: "ActionableList")
            ]
        )
    ]
)
