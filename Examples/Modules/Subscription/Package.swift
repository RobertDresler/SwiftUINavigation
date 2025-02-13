// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Subscription",
    platforms: [.iOS(.v16), .macOS(.v13), .macCatalyst(.v16)],
    products: [
        .library(
            name: "Subscription",
            targets: ["Subscription"]
        ),
    ],
    dependencies: [
        .package(path: "../../Modules/SubscriptionPremium"),
        .package(path: "../../Modules/SubscriptionFreemium"),
        .package(path: "../../../../SwiftUINavigation")
    ],
    targets: [
        .target(
            name: "Subscription",
            dependencies: [
                .product(name: "SubscriptionPremium", package: "SubscriptionPremium"),
                .product(name: "SubscriptionFreemium", package: "SubscriptionFreemium"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation")
            ]
        )
    ]
)
