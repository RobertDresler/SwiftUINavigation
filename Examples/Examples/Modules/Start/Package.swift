// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Start",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Start",
            targets: ["Start"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/UserRepository"),
        .package(path: "../../SwiftUINavigation"),
        .package(path: "../../Services/OnboardingService")
    ],
    targets: [
        .target(
            name: "Start",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "UserRepository", package: "UserRepository"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "OnboardingService", package: "OnboardingService")
            ]
        )
    ]
)
