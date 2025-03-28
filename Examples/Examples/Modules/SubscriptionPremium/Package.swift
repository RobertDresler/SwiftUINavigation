// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SubscriptionPremium",
    platforms: [.iOS(.v16), .macOS(.v13), .macCatalyst(.v16)],
    products: [
        .library(
            name: "SubscriptionPremium",
            targets: ["SubscriptionPremium"]
        ),
    ],
    dependencies: [
        .package(path: "../../../../SwiftUINavigation"),
        .package(path: "../../Shared/Shared")
    ],
    targets: [
        .target(
            name: "SubscriptionPremium",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "Shared", package: "Shared")
            ],
            resources: [.process("Resources")]
        )
    ]
)
