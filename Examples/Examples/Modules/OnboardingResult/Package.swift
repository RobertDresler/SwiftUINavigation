// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OnboardingResult",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "OnboardingResult",
            targets: ["OnboardingResult"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../SwiftUINavigation"),
        .package(path: "../../Services/OnboardingService"),
        .package(path: "../../Services/Shared")
    ],
    targets: [
        .target(
            name: "OnboardingResult",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "OnboardingService", package: "OnboardingService"),
                .product(name: "Shared", package: "Shared")
            ]
        )
    ]
)
