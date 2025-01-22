// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OnboardingService",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "OnboardingService",
            targets: ["OnboardingService"]
        )
    ],
    dependencies: [
        .package(path: "../../../../SwiftUINavigation"),
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/FlagsRepository")
    ],
    targets: [
        .target(
            name: "OnboardingService",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "FlagsRepository", package: "FlagsRepository")
            ]
        )
    ]
)
