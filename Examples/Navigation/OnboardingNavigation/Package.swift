// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OnboardingNavigation",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "OnboardingNavigation",
            targets: ["OnboardingNavigation"]
        )
    ],
    dependencies: [
        .package(path: "../../../SwiftUINavigation"),
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/OnboardingService"),
        .package(path: "../../Services/FlagsRepository"),
        .package(path: "../../Modules/OnboardingQuestion"),
        .package(path: "../../Modules/OnboardingResult")
    ],
    targets: [
        .target(
            name: "OnboardingNavigation",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "OnboardingService", package: "OnboardingService"),
                .product(name: "FlagsRepository", package: "FlagsRepository"),
                .product(name: "OnboardingQuestion", package: "OnboardingQuestion"),
                .product(name: "OnboardingResult", package: "OnboardingResult")
            ]
        )
    ]
)
