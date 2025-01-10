// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SubscriptionPremium",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SubscriptionPremium",
            targets: ["SubscriptionPremium"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../SwiftUINavigation"),
        .package(path: "../../Services/UserRepository")
    ],
    targets: [
        .target(
            name: "SubscriptionPremium",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "UserRepository", package: "UserRepository")
            ],
            resources: [.process("Resources")]
        )
    ]
)
