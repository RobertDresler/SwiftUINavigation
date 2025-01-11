// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Subscription",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Subscription",
            targets: ["Subscription"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/FlagsRepository"),
        .package(path: "../../Modules/SubscriptionPremium"),
        .package(path: "../../Modules/SubscriptionFreemium"),
        .package(path: "../../SwiftUINavigation")
    ],
    targets: [
        .target(
            name: "Subscription",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "FlagsRepository", package: "FlagsRepository"),
                .product(name: "SubscriptionPremium", package: "SubscriptionPremium"),
                .product(name: "SubscriptionFreemium", package: "SubscriptionFreemium"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation")
            ]
        )
    ]
)
