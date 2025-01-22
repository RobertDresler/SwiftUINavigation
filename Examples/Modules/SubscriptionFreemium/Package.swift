// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SubscriptionFreemium",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SubscriptionFreemium",
            targets: ["SubscriptionFreemium"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../../../SwiftUINavigation"),
        .package(path: "../../Services/FlagsRepository"),
        .package(path: "../../Services/Shared")
    ],
    targets: [
        .target(
            name: "SubscriptionFreemium",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "FlagsRepository", package: "FlagsRepository"),
                .product(name: "Shared", package: "Shared")
            ]
        )
    ]
)
